# frozen_string_literal: true

module AtomicDesign
  module Modules 
    module Helpers
      module PropHelper # :nodoc:
        class Prop < ::Hashie::Dash # :nodoc:
          include Hashie::Extensions::IgnoreUndeclared
          include ::Hashie::Extensions::DeepMerge
          # values: Array of allowed values for the property
          include ::Hashie::Extensions::Dash::PredefinedValues

          ALLOW_OPTION_KEYS = %i[values default map required].freeze

          class << self
            # Class methods go here
          end
        end

        def self.included(base)
          base.extend ClassMethods

          # initialize
          setup_prop_helper_initializer(base)
        end

        class << self
          private

          # initializerの設定を共通化
          def setup_prop_helper_initializer(klass)
            initializer = Module.new do
              define_method(:initialize) do |*args, **kwargs, &block|
                set_prop(**kwargs)

                # 親クラスのinitializeを呼び出し
                super(*args, **kwargs, &block)
              end
            end

            klass.prepend(initializer)
          end
        end

        module ClassMethods # :nodoc:
          def prop?(name)
            prop_store.property?(name)
          end

          def props
            prop_store.properties.to_a
          end

          def inherited(klass)
            super
            # 深いコピーに置き換え: 子クラスごとに独立した定義を持たせる
            # 1) 親のprop_optionsをdeep copy
            copied_options = deep_dup(prop_options)
            klass.instance_variable_set(:@prop_options, copied_options)

            # 2) 子クラス用の独立したprop_storeを新規作成し、定義を再構築
            store = Class.new(Prop)
            (copied_options || {}).each do |name, options|
              # to_hashie_optionsは破壊的に:valuesを追加する可能性があるためdupしたものを渡す
              hashie_options = to_hashie_options(**deep_dup(options))
              store.property(name, **hashie_options)
            end
            klass.instance_variable_set(:@prop_store, store)

            # 3) initializerを子にも適用
            PropHelper.send(:setup_prop_helper_initializer, klass)
          end

          def prop_options
            @prop_options || {}
          end

          def prop_store
            @prop_store ||= Class.new(Prop)
          end

          # class Component
          #   include PropStore::Helpers::PropHelper
          #   prop :title, required: true
          #   prop :description
          #   prop :color, values: %i[red green blue]
          #   prop :size, default: 'medium'
          def prop(name, **options)
            raise ArgumentError, "Invalid name: #{name}" unless allow_name?(name)
            raise ArgumentError, "Invalid options: #{options.inspect}" unless allow_options?(**options)

            prop_arg = { name.to_sym => options }

            if options.any? # rubocop:disable all
              hashie_options = to_hashie_options(**options)
            else
              hashie_options = {}
            end

            # define_accesss_method(name, **options)
            # save
            @prop_options ||= {}
            @prop_options.merge!(prop_arg)
            prop_store.property(name, **hashie_options)
          end

          private

          def allow_name?(name)
            !name.nil?
          end

          def allow_options?(**options)
            (options.keys - Prop::ALLOW_OPTION_KEYS).empty?
          end

          def to_hashie_options(**options)
            # from :map to :values
            if options.keys.include?(:map) && options[:map].is_a?(Hash) # rubocop:disable Style/IfUnlessModifier
              options[:values] = options[:map].keys
            end

            options
          end

          # ネストしたオブジェクトを安全に複製するためのヘルパー
          def deep_dup(obj)
            case obj
            when Hash
              obj.each_with_object({}) { |(k, v), h| h[k] = deep_dup(v) }
            when Array
              obj.map { |v| deep_dup(v) }
            else
              begin
                obj.dup
              rescue TypeError
                obj
              end
            end
          end

          # def define_accesss_method(name, **options)
          #   raise ArgumentError, "Method already defined: #{name}" if instance_methods.include?(name)
          #
          #   if options.keys.include?(:map)
          #     h = options[:map]
          #     define_method(name.to_s) do
          #       h[@prop.send(name.to_sym)]
          #     end
          #   else
          #     define_method(name.to_s) do
          #       @prop.send(name.to_sym)
          #     end
          #   end
          # end
        end

        private

        def prop
          @prop || raise('prop not set')
        end

        def set_prop(**options)
          @prop = self.class.prop_store.new(**options)
        end

        def dynamic_call(name)
          self.class.prop_store
          retval = @prop.send(name.to_sym)
          if (self.class.prop_options || {})[name.to_sym].keys.include?(:map)
            retval = self.class.prop_options[name.to_sym][:map][retval]
          end
          retval
        end

        # 一度propのメソッドを参照、ない場合は再度method_missingを呼び出す
        def method_missing(called, *args, **options)
          if self.class.props&.include?(called)
            dynamic_call(called)
          else
            super(called, *args, **options)
          end
        end
      end
    end
  end
end

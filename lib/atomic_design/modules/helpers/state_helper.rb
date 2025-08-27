# frozen_string_literal: true

module AtomicDesign
  module Modules
    module Helpers
      # 状態管理のヘルパー
      module StateHelper
        extend ActiveSupport::Concern

        ALLOW_STATE_OPTION_KEYS = %i[role values mapping required default].freeze
        ALLOW_STATE_OPTIONS_ROLES = %i[html value].freeze

        private_constant :ALLOW_STATE_OPTION_KEYS, :ALLOW_STATE_OPTIONS_ROLES

        included do
          extend ClassMethods
          unless instance_variable_defined?(:@prop_helper_included)
            instance_variable_set(:@prop_helper_included, true)
            StateHelper.state_helper_initializer(self)
          end
        end

        class State < ::Hashie::Dash # :nodoc:
          include Hashie::Extensions::IgnoreUndeclared
          include ::Hashie::Extensions::DeepMerge
          # values: Array of allowed values for the property
          include ::Hashie::Extensions::Dash::PredefinedValues

          class << self
            # Class methods go here
          end
        end

        module ClassMethods # :nodoc:
          def status
            @__atomic_design__modules__helpers__state_helper__class_methods__status ||= Class.new(State)
            @__atomic_design__modules__helpers__state_helper__class_methods__status.properties.to_a
          end

          #
          def state_class
            @__atomic_design__modules__helpers__state_helper__class_methods__status ||= Class.new(State)
          end

          #
          def state_options
            @__atomic_design__modules__helpers__state_helper__class_methods__state_options || {}
          end

          #
          def state?(name)
            (@__atomic_design__modules__helpers__state_helper__class_methods__state_options || {}).key?(name.to_sym)
          end

          def inherited(klass)
            super
            # 深いコピーに置き換え: 子クラスごとに独立した定義を持たせる
            # 1) 親のstate_optionsをdeep copy
            copied_options = deep_dup(@__atomic_design__modules__helpers__state_helper__class_methods__state_options)
            klass.instance_variable_set(:@__atomic_design__modules__helpers__state_helper__class_methods__state_options,
                                        copied_options)

            # 2) 子クラス用の独立したstate_storeを新規作成し、定義を再構築
            store = Class.new(State)
            (copied_options || {}).each do |name, options|
              # to_hashie_optionsは破壊的に:valuesを追加する可能性があるためdupしたものを渡す
              hashie_options = to_hashie_options(**deep_dup(options))
              store.property(name, **hashie_options)
            end
            klass.instance_variable_set(:@__atomic_design__modules__helpers__state_helper__class_methods__status, store)

            # 3) initializerを子にも適用
            StateHelper.send(:state_helper_initializer, klass)
          end

          protected

          # class Component
          #   include StateStore::Helpers::StateHelper
          #   state :title,                                                     required: true
          #   state :description
          #   state :name,                                                      required: true
          #   state :color,       values: %i[red green blue]
          #   state :size,                                    default: 'medium'
          def state(name, **options)
            raise ArgumentError, "Invalid state name: #{name}" unless allow_name?(name)
            raise ArgumentError, "Invalid state options: #{options.inspect}" unless allow_options?(**options)

            prop_arg = { name => options }

            hashie_options = to_hashie_options(**options)

            @__atomic_design__modules__helpers__state_helper__class_methods__state_options ||= {}
            @__atomic_design__modules__helpers__state_helper__class_methods__state_options.merge!(prop_arg)

            @__atomic_design__modules__helpers__state_helper__class_methods__status ||= Class.new(State)
            @__atomic_design__modules__helpers__state_helper__class_methods__status.property(name, **hashie_options)
          end

          private

          def allow_name?(name)
            !name.nil? && name.is_a?(Symbol) # && !instance_methods.include?(name.to_sym)
          end

          def allow_options?(**options)
            valid_keys = (options.keys - ALLOW_STATE_OPTION_KEYS).empty?
            valid_role = options[:role].nil? || ALLOW_STATE_OPTIONS_ROLES.include?(options[:role])

            valid_keys && valid_role
          end

          def to_hashie_options(**options)
            # from :mapping to :values
            if options.any? && options.keys.include?(:mapping) && options[:mapping].is_a?(Hash)
              options[:values] = options[:mapping].keys
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
        end

        # initializerの設定を共通化
        def self.state_helper_initializer(klass)
          prop_helper_initializer = Module.new do
            define_method(:initialize) do |*args, **kwargs, &block|
              @__atomic_design__modules__helpers__state_helper__set_state = self.class.state_class.new(**kwargs)

              super(*args, **kwargs, &block)
            end
          end

          klass.prepend(prop_helper_initializer)
        end

        protected

        # 状態を返す
        def state(name, through: false)
          hashie_value = @__atomic_design__modules__helpers__state_helper__set_state.send(name.to_sym)

          if through
            if state_role_is_html?(name)
              if state_func_is_mapping?(name)
                self.class.state_options[name.to_sym][:mapping][hashie_value]
              else
                { name.to_sym => hashie_value }
              end
            else
              if state_func_is_mapping?(name)
                self.class.state_options[name.to_sym][:mapping][hashie_value]
              else
                hashie_value
              end
            end
          else
            hashie_value
          end
        end

        # role: :html の値を全て取得する
        def state_html_values
          (self.class.state_options || {}).select { |_k, v| v[:role] == :html }.map do |n, _|
            state(n, through: true)
          end
        end

        private

        def state_func_is_mapping?(name)
          (self.class.state_options || {}).dig(name.to_sym, :mapping).present?
        end

        def state_role_is_html?(name)
          (self.class.state_options || {}).dig(name.to_sym, :role) == :html
        end

        # 一度propのメソッドを参照、ない場合は再度method_missingを呼び出す
        def method_missing(called, *args, **kwargs, &block) # rubocop:disable Style/MissingRespondToMissing
          if self.class.status&.include?(called)
            state(called, through: true)
          else
            super(called, *args, **kwargs, &block)
          end
        end
      end
    end
  end
end

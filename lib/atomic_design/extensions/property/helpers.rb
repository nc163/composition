# frozen_string_literal: true

module AtomicDesign
  module Extensions
    module Property
      module Helpers
        extend ActiveSupport::Autoload

        eager_autoload do
          # Modules
          autoload :FunctionHelpers
        end

        extend ActiveSupport::Concern
        include FunctionHelpers

        # 初期化処理
        def self.initializer
          Module.new do
            define_method(:initialize) do |*args, **kwargs, &block|
              property_resolver  = Property::Resolver.new(register: self.class.property_register)
              property_dispacher = Property::Dispacher.new(register: self.class.property_register)
              property_handler   = Property::Handler.new(register: property_resolver, resolver: property_resolver, dispacher: property_dispacher)

              super(*args, **kwargs, &block) if defined?(super)
            end
          end
        end

        included do
          @property_register ||= Register.new

          unless instance_variable_defined?(:@property_helper_included)
            instance_variable_set(:@property_helper_included, true)
            self.prepend(AtomicDesign::Extensions::Property::Helpers.initializer)
          end
        end

        module ClassMethods
          def inherited(klass)
            super
            klass.instance_variable_set(:@property_register, @property_register.clone)
            klass.prepend(AtomicDesign::Extensions::Property::Helpers.initializer)
          end

          def property_register
            @property_register
          end

          extend Forwardable
          def_delegator :@property_register, :list, :properties
          def_delegator :@property_register, :find, :get_property
          protected
          def_delegator :@property_register, :add,  :def_property
        end

        # HTML属性
        def html_options
          @html_options.flatten.compact.reduce { _1.merge(_2, &method(:merge_html_attributes)) }
        end

        private

        # 色々なHTML属性のマージを頑張る
        def merge_html_attributes(key, old_value, new_value)
          raise ArgumentError, "Key must be a Symbol" unless key.is_a?(Symbol)

          case key
          when :id, :class
            [ old_value, new_value ].compact.join(" ")
          when :style
            [ old_value, new_value ].compact.join("; ")
          when :data, :arel
            old_value.to_h.merge(new_value.to_h)
          else
            [ old_value, new_value ].compact.join(" ")
          end
        end

        private

        # 一度propのメソッドを参照、ない場合は再度method_missingを呼び出す
        def method_missing(called, *args, **kwargs, &block)
          # if self.class.properties.include?(called)
          #   return property_resolve(called, *args, **kwargs, &block)
          # end

          super(called, *args, **kwargs, &block)
        end
      end
    end
  end
end

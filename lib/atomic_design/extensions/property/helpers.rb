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
              @property_resolver  = Property::Resolver.new(register: property_register)
              @property_dispacher = Property::Dispacher.new(register: property_register)
              @property_handler   = Property::Handler.new(register: property_register, resolver: @property_resolver, dispacher: @property_dispacher)
              @property_handler.dispatch(**kwargs)

              super(*args, **kwargs, &block) if defined?(super)
            end
          end
        end

        included do
          @property_register ||= Property::Register.new

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
          protected
          def_delegator :@property_register, :add,  :def_property
        end

        def state(name)
          @property_handler.invoke(name)
        end

        # HTML属性
        def html_options
          @property_handler.html_options
        end

        private

        # プロパティではない場合は、再度method_missingを呼び出す
        def method_missing(called, *args, **kwargs, &block)
          if @property_handler.invokable?(called)
            if args.empty? && kwargs.empty? && !block_given?
              @property_handler.invoke(called.to_sym)
            else
              raise ArgumentError, "Invalid arguments for property #{called}"
            end
          else
            super(called, *args, **kwargs, &block)
          end
        end

        def property_register
          self.class.property_register
        end
      end
    end
  end
end

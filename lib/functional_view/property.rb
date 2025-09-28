# frozen_string_literal: true

require "forwardable"

module FunctionalView
  module Property
    extend ActiveSupport::Autoload
    eager_autoload do
      # Class
      autoload :FunctionRegister
      autoload :FunctionBuilder
      autoload :Context
      autoload :State
      # Module
      autoload :Functions
      autoload :Contextable
      autoload :Statable
    end

    extend ActiveSupport::Concern
    include Contextable
    include Statable
    included do
      @function_register ||= FunctionRegister.new

      prepend InstanceMethods
      class << self
        def inherited(klass)
          klass.prepend(Property::InstanceMethods)
          super
        end
      end
    end

    extend Forwardable
    attr_accessor :function_resolver

    module InstanceMethods
      def initialize(*args, **kwargs, &block)
        missing_required = function_register.select(&:required?).pluck(:name) - kwargs.keys
        raise ArgumentError, "Missing required properties: #{missing_required.join(', ')}" if missing_required.any?

        @function_resolver ||= FunctionResolver.new(function_register, kwargs)

        super if defined?(super)
      end
    end

    module ClassMethods # :nodoc:
      def inherited(klass)
        super
        klass.instance_variable_set(:@function_register, function_register.clone)
      end

      attr_accessor :function_register

      protected

      def def_function(**function_options)
        function = Functions::Spec.new(**function_options)
        function_register.add function
        define_action_method function
        define_access_method function
      end

      private

      def define_action_method(function)
        return unless method_type = function.type

        define_method(method_type) do |method_name|
          function_resolver.action_resolve(method_type, method_name)
        end unless method_defined?(method_type)
      end

      def define_access_method(function)
        return unless method_name = function.to

        define_method(method_name) do
          function_resolver.access_resolve(method_name)
        end unless method_defined?(method_name)
      end
    end

    def without_property(**options)
      function_resolver.without(**options)
    end

    #
    def function_register
      self.class.function_register
    end
  end
end

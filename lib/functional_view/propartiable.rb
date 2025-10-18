# frozen_string_literal: true

require "forwardable"

module FunctionalView
  module Propartiable
    extend ActiveSupport::Concern
    included do
      @property ||= Property.new

      prepend InstanceMethods
      class << self
        def inherited(klass)
          klass.prepend(InstanceMethods)
          super
        end
      end
    end

    attr_accessor :function_resolver

    module InstanceMethods
      def initialize(*args, **kwargs, &block)
        missing_required = property.select(&:required?).pluck(:name) - kwargs.keys
        raise ArgumentError, "Missing required properties: #{missing_required.join(', ')}" if missing_required.any?

        @function_resolver ||= PropertyResolver.new(property, kwargs)
        super if defined?(super)
      end
    end

    include Modules

    module ClassMethods # :nodoc:
      def inherited(klass)
        super
        klass.instance_variable_set(:@property, property.clone)
      end

      attr_accessor :property

      protected

      def def_function(function)
        raise unless function.is_a?(Function)

        property.append function
        define_action_method function
        # define_action_method function
      end

      private

      def define_action_method(function)
        return unless method_type = function.type

        define_method(method_type) do |method_name|
          function_resolver.action_resolve(method_type, method_name)
        end unless method_defined?(method_type)
      end
    end

    #
    def property
      self.class.property
    end

    def without_property(**options)
      function_resolver.without(**options)
    end
  end
end

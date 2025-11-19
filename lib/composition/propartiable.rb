# frozen_string_literal: true

require "forwardable"

module Composition
  module Propartiable
    extend ActiveSupport::Concern
    included do
      @property_set ||= PropertySet.new

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
        missing_required = property_set.select(&:required?).pluck(:name) - kwargs.keys
        raise ArgumentError, "Missing required properties: #{missing_required.join(', ')}" if missing_required.any?

        @function_resolver ||= Resolver.new(property_set, kwargs)
        super if defined?(super)
      end
    end

    include Modules

    module ClassMethods # :nodoc:
      attr_accessor :property_set

      def inherited(klass)
        super
        klass.instance_variable_set(:@property_set, property_set.clone)
      end

      def property
        property_set.pluck(:name)
      end

      def def_property(property)
        raise unless property.is_a?(Property)

        property_set.append property
        define_property_access_method property
      end

      private

      def define_property_access_method(property)
        return unless method_type = property.to

        define_method(method_type) do
          function_resolver.access_resolve(method_type)
        end unless method_defined?(method_type)
      end
    end

    #
    def property(property_name)
      function_resolver.action_resolve(property_name)
    end

    #
    def property?(property_name)
      !!function_resolver.action_resolve(property_name)
    end

    #
    def property_set
      self.class.property_set
    end

    def without_property
      function_resolver.without_property
    end
  end
end

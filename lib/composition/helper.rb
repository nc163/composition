# frozen_string_literal: true

module Composition
  module Helper
    def view_component
      module_proxy
    end

    class ModuleBuilder # :nodoc:
      def initialize(namespace_snake_case)
        @namespace = namespace_snake_case
      end

      attr_reader :namespace

      def arbit(names_snake_case, *args, **kwargs, &block)
        klass_or_module_string = "#{namespace}/#{names_snake_case}"
        klass_or_module = klass_or_module_string.camelize.safe_constantize

        return build!(klass_or_module, *args, **kwargs, &block) if klass_or_module.is_a?(Class)
        return recall!(klass_or_module_string, *args, **kwargs, &block) if klass_or_module.is_a?(Module)

        nil
      end

      private

      def build!(cls, *args, **kwargs, &block)
        cls.new(*args, **kwargs, &block)
      end

      def recall!(mod, *args, **kwargs, &block)
        self.class.new(mod, *args, **kwargs, &block)
      end

      def respond_to_missing?(*args)
        true
      end

      def method_missing(called, *args, **kwargs, &block)
        res = arbit(called, *args, **kwargs, &block)
        return res unless res.nil?

        super(called, *args, **kwargs)
      end
    end

    class ModuleProxy # :nodoc:
      MODULES_PATH = "atomic_design/modules"

      # Returns the atoms modules
      def atoms
        @atoms ||= builder(:atoms)
      end

      # Returns the molecules modules
      def moles
        @moles ||= builder(:moles)
      end

      # Returns the organisms modules
      def orgas
        @orgas ||= builder(:orgas)
      end

      # Returns the templates modules
      def temps
        @temps ||= builder(:temps)
      end

      # Returns the pages modules
      def pages
        @pages ||= builder(:pages)
      end

      private

      def builder(module_name)
        ModuleBuilder.new("#{MODULES_PATH}/#{module_name}")
      end
    end

    private

    def module_proxy
      @module_proxy ||= ModuleProxy.new
    end
  end
end

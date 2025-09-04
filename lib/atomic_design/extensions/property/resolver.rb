# frozen_string_literal: true

require "forwardable"

module AtomicDesign
  module Extensions
    module Property
      #
      class Resolver
        attr_accessor :register
        extend Forwardable
        def_delegator :register, :exist?, :function_exist?
        def_delegator :register, :find, :find_function

        def initialize(register:)
          @register = register
        end

        def resolve(name, value = nil)
          raise ArgumentError, "Function not found: #{name}" unless function_exist?(name)
          function = find_function(name)
          # function.resolve(value)
          #
          value = value || function[:default]
          raise ArgumentError, "Missing required property: #{name}" if function.required? && value.nil?

          case function.type
          when :basic
            function[:value]
          when :state
            if function.keys.include?(:map)
              function[:map][value.to_sym]
            else
              value
            end
          when :effect
            function[:proc].call(value)
          end
        end
      end
    end
  end
end

# frozen_string_literal: true

require "forwardable"

module AtomicDesign
  module Extensions
    module Property
      #
      class Resolver
        extend Forwardable
        def_delegator :register, :find, :find_function

        def resolves(**kwargs)
          kwargs.map { |k, v| resolve(k, v) }
        end

        def resolve(name, value)
          function = find_function(name)
          raise ArgumentError, "Function not found: #{name}" unless function

          function.resolve(value)
        end
      end
    end
  end
end

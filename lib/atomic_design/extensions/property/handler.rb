# frozen_string_literal: true

require "forwardable"

module AtomicDesign
  module Extensions
    module Property
      #
      class Handler
        attr_accessor :registry
        extend Forwardable
        def_delegators :registry, :find

        def invoke?(name)
          !!find(name)
        end

        # functionへセット
        def invoke(name, value)
          function = find(name)
          raise ArgumentError, "Function not found: #{name}" unless function

          function.resolve(value)
        end

        private

        #
        def dispatch(result)
          case result
          in { to:, value: }
            case to
            when :html
              @html_options ||= []
              @html_options << value
            end
          end
        end
      end
    end
  end
end

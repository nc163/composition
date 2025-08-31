# frozen_string_literal: true

module AtomicDesign
  module Modules
    module Helpers
      module PropertyHelpers
        class State < Property  # :nodoc:
          def function
            METHOD
          end

          def get_value(value)
            value
          end
        end
      end
    end
  end
end

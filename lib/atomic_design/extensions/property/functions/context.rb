# frozen_string_literal: true

module AtomicDesign
  module Extensions
    module Property
      module Functions
        class Context < Property::Function # :nodoc:
          def initialize(**options)
            options[:type] = :context
            options[:to]   = :html
            super(**options)
          end

          protected

          def skip_option_check
            true
          end
        end
      end
    end
  end
end

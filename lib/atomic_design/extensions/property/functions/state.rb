# frozen_string_literal: true

module AtomicDesign
  module Extensions
    module Property
      module Functions
        class State < Property::Function  # :nodoc:
          def initialize(**options)
            options[:type] = :state
            super(**options)
          end

          def map
            self[:map]
          end

          protected

          def allow_options
            [ :map ]
          end
        end
      end
    end
  end
end

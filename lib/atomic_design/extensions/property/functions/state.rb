# frozen_string_literal: true

module AtomicDesign
  module Extensions
    module Property
      module Functions
        class State < Function  # :nodoc:
          def map
            self[:map]
          end

          protected

          def resolve(value)
            if !!map && map.is_a?(Hash)
              map[value.to_sym]
            else
              value
            end
          end

          def allow_options
            [ :map ]
          end
        end
      end
    end
  end
end

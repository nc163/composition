# frozen_string_literal: true

module AtomicDesign
  module Extensions
    module Property
      module Functions
        class State < Base  # :nodoc:
          def initialize(map: nil, **options)
            super(**options)

            self[:map] = map
          end

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
        end
      end
    end
  end
end

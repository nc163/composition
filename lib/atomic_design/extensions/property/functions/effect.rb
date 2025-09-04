# frozen_string_literal: true

module AtomicDesign
  module Extensions
    module Property
      module Functions
        class Effect < Property::Function # :nodoc:
          def initialize(**options)
            options[:type] = :effect
            super(**options)
          end

          def proc
            self[:proc]
          end

          protected

          def allow_options
            [ :proc ]
          end
        end
      end
    end
  end
end

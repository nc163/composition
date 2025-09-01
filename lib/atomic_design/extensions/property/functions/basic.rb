# frozen_string_literal: true

module AtomicDesign
  module Extensions
    module Property
      module Functions
        class Basic < Function # :nodoc:
          protected

          def resolve(_)
            self[:value]
          end

          def allow_options
            [ :value ]
          end
        end
      end
    end
  end
end

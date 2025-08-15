# frozen_string_literal: true

# ==
module AtomicDesign
  module Component

      module Molecule
        class Dialog < Component

          # == Methods

          def call
            content_tag :dialog, attributes do
              context || content
            end
          end

        end
      end
  end
end

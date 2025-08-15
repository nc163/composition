# frozen_string_literal: true

# ==
module Design
  module Component
    module AtomicDesign
      module Molecules
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
end

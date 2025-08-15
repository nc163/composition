# frozen_string_literal: true

#
module Design
  module Component
    module AtomicDesign
      module Atoms
        module Metadata
          class Date < Atoms::Component

            def call
              content_tag :span, attributes do
                concat(content_tag :i, nil, class: 'fa-regular fa-calendar me-2')
                concat(content_tag :span, context, class: '')
              end
            end

          end
        end
      end
    end
  end
end

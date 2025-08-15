# frozen_string_literal: true

#
module Design
  module Component
    module AtomicDesign
      module Atoms
        module Metadata
          class Heart < Atomc::Component

            property :size, sm: { class: '' },
                            md: { class: 'd-flex flex-column align-items-center' }

            def call
              content_tag :span, attributes do
                concat(content_tag(:i, nil, class: 'fa-regular fa-heart me-2'))
                concat(content_tag(:span, context, class: ''))
              end
            end

          end
        end
      end
    end
  end
end

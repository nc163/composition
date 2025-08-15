# frozen_string_literal: true

#
module AtomicDesign
  module Component

      module Atom
        module Metadata
          class Phone < Atomc::Component

            property :size, sm: { class: '' },
                            md: { class: 'd-flex flex-column align-items-center' }

            def call
              content_tag :p, attributes do
                concat(content_tag(:i, nil, class: 'fa-solid fa-phone me-2'))
                concat(phone_to(context, context, class: ''))
              end
            end

          end
        end
      end
  end
end

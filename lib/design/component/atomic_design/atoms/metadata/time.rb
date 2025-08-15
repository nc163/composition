# frozen_string_literal: true

#
module Design
  module Component
    module AtomicDesign
      module Atoms
        module Metadata
          class Time < Atomc::Component

            def call
              content_tag :span, attributes do
                concat(content_tag :i, nil, class: 'fa-regular fa-clock me-2', 'aria-hidden': true )
                concat(content_tag :span, context, class: '')
              end
            end

          end
        end
      end
    end
  end
end

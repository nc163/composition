# frozen_string_literal: true

#
module AtomicDesign
  module Components
    module Atoms # :nodoc:
      module Metadata
        class Star < Atomc::Components
          def call
            content_tag :span, attributes do
              concat(content_tag(:i, nil, class: 'fa-regular fa-star me-2'))
              concat(content_tag(:span, context, class: ''))
            end
          end
        end
      end
    end
  end
end

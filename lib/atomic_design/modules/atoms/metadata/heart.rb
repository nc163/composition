# frozen_string_literal: true

#
module AtomicDesign
  module Modules
    module Atoms # :nodoc:
      module Metadata
        class Heart < Atomc::Modules
          property :size, sm: { class: '' },
                          md: { class: 'd-flex flex-column align-items-center' }

          def call
            content_tag :span, options do
              concat(content_tag(:i, nil, class: 'fa-regular fa-heart me-2'))
              concat(content_tag(:span, context, class: ''))
            end
          end
        end
      end
    end
  end
end

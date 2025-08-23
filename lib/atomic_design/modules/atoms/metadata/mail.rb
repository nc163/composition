# frozen_string_literal: true

#
module AtomicDesign
  module Modules
    module Atoms # :nodoc:
      module Metadata
        class Mail < Atomc::Modules
          property :size, sm: { class: '' },
                          md: { class: 'd-flex flex-column align-items-center' }

          def call
            content_tag :p, attributes do
              concat(content_tag(:i, nil, class: 'fa-regular fa-envelope me-2'))
              concat(mail_to(context, context, class: ''))
            end
          end
        end
      end
    end
  end
end

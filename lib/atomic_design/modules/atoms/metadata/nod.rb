# frozen_string_literal: true

#
module AtomicDesign
  module Modules
    module Atoms # :nodoc:
      module Metadata
        class Nod < Atomc::Modules
          def call
            content_tag :span, options do
              concat(content_tag(:i, nil, class: 'fa-regular fa-thumbs-up me-2'))
              concat(content_tag(:span, context, class: ''))
            end
          end
        end
      end
    end
  end
end

# frozen_string_literal: true

#
module AtomicDesign
  module Modules
    module Atoms # :nodoc:
      module Metadata
        class Date < Atoms::Modules
          def call
            content_tag :span, options do
              concat(content_tag(:i, nil, class: 'fa-regular fa-calendar me-2'))
              concat(content_tag(:span, context, class: ''))
            end
          end
        end
      end
    end
  end
end

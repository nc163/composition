# frozen_string_literal: true

#
module AtomicDesign
  module Modules
    module Atoms # :nodoc:
      module Metadata
        class Time < Atomc::Modules
          def call
            content_tag :span, options do
              concat(content_tag(:i, nil, class: 'fa-regular fa-clock me-2', 'aria-hidden': true))
              concat(content_tag(:span, context, class: ''))
            end
          end
        end
      end
    end
  end
end

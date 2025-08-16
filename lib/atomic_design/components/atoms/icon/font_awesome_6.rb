# frozen_string_literal: true

#
module AtomicDesign
  module Components
    module Atoms # :nodoc:
      class Icon::FontAwesome6 < ::AtomicDesign::Components::Base
        # == Layout
        default_layout 'aria-hidden': true

        property :icon, question: { class: 'fa-solid fa-question' },
                        exclamation: { class: 'fa-solid fa-exclamation' },
                        heart: { class: 'fa-solid fa-heart', style: 'color: #ff091a;' },
                        star: { class: 'fa-solid fa-star', style: 'color: #FFD43B;' },
                        nod: { class: 'fa-regular fa-thumbs-up' }

        # == Attributes
        attr_accessor :alt

        def call
          content_tag :i, alt, attributes
        end

        private
      end
    end
  end
end

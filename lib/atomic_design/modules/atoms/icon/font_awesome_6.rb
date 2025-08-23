# frozen_string_literal: true

#
module AtomicDesign
  module Modules
    module Atoms # :nodoc:
      module Icon
        class FontAwesome6 < ::AtomicDesign::Base
          ICONS = {
            question: { class: 'fa-solid fa-question' },
            exclamation: { class: 'fa-solid fa-exclamation' },
            heart: { class: 'fa-solid fa-heart', style: 'color: #ff091a;' },
            star: { class: 'fa-solid fa-star', style: 'color: #FFD43B;' },
            nod: { class: 'fa-regular fa-thumbs-up' }
          }.freeze

          attributes 'aria-hidden': true

          prop :icon, map: ICONS, required: true

          def self.icons
            ICONS.keys
          end
        end
      end
    end
  end
end

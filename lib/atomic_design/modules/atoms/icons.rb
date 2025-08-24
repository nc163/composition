# frozen_string_literal: true

module AtomicDesign
  module Modules
    module Atoms
      module Icons # :nodoc:
        extend ActiveSupport::Autoload

        eager_autoload do
          autoload :FontAwesome6
          autoload :Emoji
        end

        EMOJI_COLOR = {
          red: { style: 'color: transparent; text-shadow: 0 0 0 #e9c538' }
        }.freeze

        FONT_AWESOME_6_ICONS = {
          question: { class: 'fa-solid fa-question' },
          exclamation: { class: 'fa-solid fa-exclamation' },
          heart: { class: 'fa-solid fa-heart', style: 'color: #ff091a;' },
          star: { class: 'fa-solid fa-star', style: 'color: #FFD43B;' },
          nod: { class: 'fa-regular fa-thumbs-up' }
        }.freeze
      end
    end
  end
end

# frozen_string_literal: true

module AtomicDesign
  module Modules
    module Atoms
      module Icons # :nodoc:
        extend ActiveSupport::Autoload

        eager_autoload do
          # Class
          autoload :FontAwesome7
          autoload :FontAwesome6
          autoload :BootstrapIcon
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

        FONT_AWESOME_7_ICONS = {
          question: { class: 'fa-solid fa-question' },
          exclamation: { class: 'fa-solid fa-exclamation' },
          heart: { class: 'fa-solid fa-heart', style: 'color: #ff091a;' },
          star: { class: 'fa-solid fa-star', style: 'color: #FFD43B;' },
          nod: { class: 'fa-regular fa-thumbs-up' }
        }.freeze

        FONT_AWESOME_7_SIZES = {
          xxs: { class: 'fa-2xs' },
          xs: { class: 'fa-xs' },
          sm: { class: 'fa-sm' },
          lg: { class: 'fa-lg' },
          xl: { class: 'fa-xl' },
          xxl: { class: 'fa-2xl' }
        }.freeze
        FONT_AWESOME_7_ROTATES = {
          r90: { class: 'fa-rotate-90' },
          sm: { class: 'fa-sm' },
          lg: { class: 'fa-lg' },
          xl: { class: 'fa-xl' },
          xxl: { class: 'fa-2xl' }
        }.freeze
      end
    end
  end
end

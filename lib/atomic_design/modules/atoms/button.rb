# frozen_string_literal: true

module AtomicDesign
  module Modules
    module Atoms # :nodoc:
      # ボタンコンポーネント
      # `<span class='btn'>{{content}}</span>`
      class Button < Base
        basic class: "btn"
        state :color, map: BUTTON_COLORS,     default: :primary,  to: :html

        def self.colors
          BUTTON_COLORS.keys
        end
      end
    end
  end
end

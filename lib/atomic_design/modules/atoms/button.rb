# frozen_string_literal: true

module AtomicDesign
  module Modules
    module Atoms # :nodoc:
      # ボタンコンポーネント
      # `<span class='btn'>{{content}}</span>`
      class Button < Base # :nodoc:
        defaults class: 'btn'

        state :color, role: :html, mapping: BUTTON_COLORS, default: :primary

        def self.colors
          BUTTON_COLORS.keys
        end
      end
    end
  end
end

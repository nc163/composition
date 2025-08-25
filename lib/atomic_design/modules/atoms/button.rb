# frozen_string_literal: true

module AtomicDesign
  module Modules
    module Atoms # :nodoc:
      # ボタンコンポーネント
      # `<span class='btn'>{{content}}</span>`
      class Button < Base # :nodoc:
        attrs class: 'btn'

        prop :color, mapping: BUTTON_COLORS, default: :primary

        def self.colors
          BUTTON_COLORS.keys
        end
      end
    end
  end
end

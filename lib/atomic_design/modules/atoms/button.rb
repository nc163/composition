# frozen_string_literal: true

module AtomicDesign
  module Modules
    module Atoms # :nodoc:
      # ボタンコンポーネント
      # `<span class='btn'>{{content}}</span>`
      class Button < ::AtomicDesign::Modules::Base
        attributes class: 'btn'

        prop :color, map: BUTTON_COLORS, default: :primary

        def self.colors
          BUTTON_COLORS.keys
        end
      end
    end
  end
end

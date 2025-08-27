# frozen_string_literal: true

module AtomicDesign
  module Modules
    module Atoms
      module Icons
        class FontAwesome7 < Base # :nodoc:
          defaults 'aria-hidden': true

          state :icon, mapping: FONT_AWESOME_7_ICONS, required: true
          state :size, mapping: FONT_AWESOME_7_SIZES, required: true

          def self.icons
            FONT_AWESOME_7_ICONS.keys
          end
        end
      end
    end
  end
end

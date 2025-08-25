# frozen_string_literal: true

module AtomicDesign
  module Modules
    module Atoms
      module Icons
        class FontAwesome6 < Base # :nodoc:
          defaults 'aria-hidden': true

          state :icon, mapping: FONT_AWESOME_6_ICONS, required: true

          def self.icons
            FONT_AWESOME_6_ICONS.keys
          end
        end
      end
    end
  end
end

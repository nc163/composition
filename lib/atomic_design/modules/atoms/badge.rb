# frozen_string_literal: true

module AtomicDesign
  module Modules
    module Atoms
      class Badge < Base # :nodoc:
        attrs class: 'badge'

        prop :color, map: BADGE_COLORS, default: :primary

        def self.colors
          BADGE_COLORS.keys
        end
      end
    end
  end
end

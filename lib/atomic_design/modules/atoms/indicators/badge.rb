# frozen_string_literal: true

module AtomicDesign
  module Modules
    module Atoms
      module Indicators
        class Badge < Base # :nodoc:
          basic class: "badge"
          state :size,  map: BADGE_SIZES,  default: :sm,   to: :html
          state :alert, map: ALERT_LEVELS, default: :info, to: :html

          def self.alerts
            ALERT_LEVELS.keys
          end

          def self.sizes
            BADGE_SIZES.keys
          end
        end
      end
    end
  end
end

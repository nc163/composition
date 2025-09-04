# frozen_string_literal: true

module AtomicDesign
  module Modules
    module Atoms
      module Indicators
        class Badge < Base # :nodoc:
          basic class: "badge"

          state :size,  role: :html, mapping: BADGE_SIZES,  default: :sm
          state :alert, role: :html, mapping: ALERT_LEVELS, default: :info

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

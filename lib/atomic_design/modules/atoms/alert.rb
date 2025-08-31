# frozen_string_literal: true

module AtomicDesign
  module Modules
    module Atoms
      class Alert < Base # :nodoc:
        state :level, to: ALERT_LEVELS, default: :danger
        effect :level, proc: ALERT_LEVELS, default: :danger

        def self.levels
          ALERT_LEVELS.keys
        end
      end
    end
  end
end

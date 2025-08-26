# frozen_string_literal: true

module AtomicDesign
  module Modules
    module Atoms
      class Alert < Base # :nodoc:
        # state :level, mapping: ALERT_LEVELS, default: :danger

        def self.levels
          ALERT_LEVELS.keys
        end
      end
    end
  end
end

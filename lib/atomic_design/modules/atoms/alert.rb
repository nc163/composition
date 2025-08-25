# frozen_string_literal: true

module AtomicDesign
  module Modules
    module Atoms
      class Alert < Base # :nodoc:
        prop :level, map: ALERT_LEVELS, default: :danger

        def self.levels
          ALERT_LEVELS.keys
        end
      end
    end
  end
end

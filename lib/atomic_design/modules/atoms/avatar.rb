# frozen_string_literal: true

module AtomicDesign
  module Modules
    module Atoms
      class Avatar < Base # :nodoc:
        basic class: "rounded-circle"

        state :size, to: :html, map: AVATAR_SIZES, default: :md
        state :name

        def self.sizes
          AVATAR_SIZES.keys
        end
      end
    end
  end
end

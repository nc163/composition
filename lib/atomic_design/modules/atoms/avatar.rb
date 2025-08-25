# frozen_string_literal: true

module AtomicDesign
  module Modules
    module Atoms
      class Avatar < Base # :nodoc:
        attrs class: 'rounded-circle', alt: 'avatar'

        # prop :size, map: AVATAR_SIZES, default: :medium

        def self.sizes
          AVATAR_SIZES.keys
        end
      end
    end
  end
end

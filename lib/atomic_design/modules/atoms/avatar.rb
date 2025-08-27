# frozen_string_literal: true

module AtomicDesign
  module Modules
    module Atoms
      class Avatar < Base # :nodoc:
        defaults class: 'rounded-circle'

        state :size, role: :html, mapping: AVATAR_SIZES, default: :md
        # effect :name, role: :html, effect: (name) -> { alt: name }, default: 'avatar'

        def self.sizes
          AVATAR_SIZES.keys
        end
      end
    end
  end
end

# frozen_string_literal: true

module AtomicDesign
  module ModulePreviews
    module Atoms
      class AvatarPreview < Base # :nodoc:
        CONTEXT = "/assets/images/60x60.png"
        # @!group Sizes

        # @param size select :sizes
        def default(size: :sm)
          render atomic_design.atoms.avatar(CONTEXT)
        end

        # @!endgroup

        private

        def sizes
          { choices: Avatar.sizes }
        end
      end
    end
  end
end

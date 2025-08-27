# frozen_string_literal: true

module AtomicDesign
  module Modules
    module Atoms
      class AvatarPreview < ::AtomicDesign::Modules::Preview # :nodoc:
        CONTEXT = '/assets/images/60x60.png'
        # @!group Sizes

        # @param size select :sizes
        def default
          render atomic_design.atoms.avatar(CONTEXT)
        end

        # @!endgroup

        def sizes
          Avatar.sizes
        end
      end
    end
  end
end

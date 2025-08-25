# frozen_string_literal: true

module AtomicDesign
  module Modules
    module Atoms
      class AvatarPreview < Preview # :nodoc:
        # @!group default

        def default(url = '/assets/images/60x60.png')
          render atomic_design.atoms.avatar(url)
        end
      end
    end
  end
end

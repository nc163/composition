# frozen_string_literal: true

module AtomicDesign
  module Modules
    module Atoms
      class AvatarPreview < Preview # :nodoc:
        # @!group default

        # @param context
        def default(context = 'Example', url = '', alt: '')
          render atomic_design.atoms.avatar.new(context, url, alt: alt)
        end
      end
    end
  end
end

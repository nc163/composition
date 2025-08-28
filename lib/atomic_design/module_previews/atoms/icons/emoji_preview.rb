# frozen_string_literal: true

module AtomicDesign
  module ModulePreviews
    module Atoms
      module Icons
        class EmojiPreview < Base # :nodoc:
          # @!group default

          # @param icon select :icons
          def default(icon: :question)
            render atomic_design.atoms.icons.emoji(nil, icon: icon)
          end

          private

          def icons
            { choices: Emoji.icons }
          end
        end
      end
    end
  end
end

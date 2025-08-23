# frozen_string_literal: true

#
module AtomicDesign
  module Modules
    module Atoms
      module Icon
        class EmojiPreview < ::ViewComponent::Preview
          # @!group default

          # @param icon select :icons
          def default(icon: :question)
            render Emoji.new(nil, icon: icon)
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

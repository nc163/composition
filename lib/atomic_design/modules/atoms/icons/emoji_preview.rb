# frozen_string_literal: true

module AtomicDesign
  module Modules
    module Atoms
      module Icons
        class EmojiPreview < Preview # :nodoc:
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

# frozen_string_literal: true

module AtomicDesign
  module Modules
    module Atoms
      module Icons
        class Emoji < Base # :nodoc:
          state :icon, mapping: EMOJI_COLOR, required: true
          state :emoji, required: true
        end
      end
    end
  end
end

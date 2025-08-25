# frozen_string_literal: true

module AtomicDesign
  module Modules
    module Atoms
      module Icons
        class Emoji < Base # :nodoc:
          prop :icon, mapping: EMOJI_COLOR, required: true
          prop :emoji, required: true
        end
      end
    end
  end
end

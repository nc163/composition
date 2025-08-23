# frozen_string_literal: true

#
module AtomicDesign
  module Modules
    module Atoms
      module Icon
        class Emoji < ::AtomicDesign::Base # :nodoc:
          COLOR = {
            red: { style: 'color: transparent; text-shadow: 0 0 0 #e9c538' },
          }.freeze

          prop :icon, map: COLOR, required: true
          prop :emoji, required: true
        end
      end
    end
  end
end

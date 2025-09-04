# frozen_string_literal: true

module AtomicDesign
  module Modules
    module Moles
      class Card::Body < Base # :nodoc:
        basic class: "card-body"

        def call
          content_tag :div, options do
            concat(content || context)
          end
        end
      end
    end
  end
end

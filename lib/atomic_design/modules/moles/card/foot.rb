# frozen_string_literal: true

module AtomicDesign
  module Modules
    module Moles
      class Card::Foot < Base # :nodoc:
        # == Layout
        basic class: "card-footer"

        def call
          content_tag :footer, options do
            content
          end
        end
      end
    end
  end
end

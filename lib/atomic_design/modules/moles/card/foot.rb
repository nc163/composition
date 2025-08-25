# frozen_string_literal: true

#
module AtomicDesign
  module Modules
    module Moles # :nodoc:
      class Card::Foot < Base # :nodoc:
        # == Layout
        attrs class: 'card-footer'

        def call
          content_tag :footer, options do
            content
          end
        end
      end
    end
  end
end

# frozen_string_literal: true

#
module AtomicDesign
  module Modules
    module Moles
      class CardPreview < ::ViewComponent::Preview # :nodoc:
        # @!group default

        # @param title
        # @param body
        # @param foot
        def block(title: 'Example', body: 'body', foot: 'footer')
          render Card.new do |card|
            card.with_head(title)
            card.with_body do |slot|
              body
            end
            card.with_foot do |slot|
              foot
            end
          end
        end
      end
    end
  end
end

# frozen_string_literal: true

module AtomicDesign
  module ModulePreviews
    module Moles
      class CardPreview < Base # :nodoc:
        # @param title
        # @param body
        # @param foot
        def default(title: 'Example', body: 'body', foot: 'footer')
          render atomic_design.moles.card do |card|
            card.with_head(title)
            card.with_body do |slot|
              content_tag :span, body, class: 'text-secondary'
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

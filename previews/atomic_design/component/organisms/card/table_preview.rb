# frozen_string_literal: true

#
module AtomicDesign
  module Component

      module Organism
        module Card
          class TablePreview < ViewComponent::Preview
          
            def default
              render Table.new WebPage.page(1).per(10)
            end
          
          
          end
        end
      end
  end
end
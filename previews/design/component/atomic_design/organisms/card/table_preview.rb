# frozen_string_literal: true

#
module Design
  module Component
    module AtomicDesign
      module Organisms
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
end
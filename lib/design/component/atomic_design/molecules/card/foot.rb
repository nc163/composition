# frozen_string_literal: true

#
module Design
  module Component
    module AtomicDesign
      module Molecules
        class Card::Foot < Component
        
          # == Layout
          default_layout class: 'card-footer'
        
          # == Methods
        
          def call
            content_tag :footer, attributes do
              content
            end
          end
        
        end
      end
    end
  end
end

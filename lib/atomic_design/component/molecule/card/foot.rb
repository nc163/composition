# frozen_string_literal: true

#
module AtomicDesign
  module Component

      module Molecule
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

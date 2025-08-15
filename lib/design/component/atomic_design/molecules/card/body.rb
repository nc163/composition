# frozen_string_literal: true

#
module Design
  module Component
    module AtomicDesign
      module Molecules
        class Card::Body < Component
        
          # == Layout
          default_layout class: 'card-body'
        
          # == Attributes
          # Nop
        
          # == Methods
        
          def call
            content_tag :div, attributes do
              concat(content || context)
            end
          end
        
        end
      end
    end
  end
end

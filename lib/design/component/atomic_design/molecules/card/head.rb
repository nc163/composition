# frozen_string_literal: true

#
module Design
  module Component
    module AtomicDesign
      module Molecules
        class Card::Head < Component
        
          # == Layout
          default_layout class: 'card-header fw-bold'
        
          # == Attributes
          #
        
          # == Methods
        
          def call
            content_tag :header, attributes do
              if content?
                content
              else
                context
              end
            end
          end
        
        end
      end
    end
  end
end

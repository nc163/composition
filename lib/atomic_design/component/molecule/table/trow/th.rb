# frozen_string_literal: true

#
module AtomicDesign
  module Component

      module Molecule
        class Table::Trow::Th < Component
        
          # == Slots
          # renders_one :button, AtomicDesign::Atom::Button
        
          # attr_accessor :text
        
          # == Methods
        
          def call
            content_tag :th, attributes do
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

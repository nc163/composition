# frozen_string_literal: true

#
module Design
  module Component
    module AtomicDesign
      module Molecules
        class Table::Trow::Th < Component
        
          # == Slots
          # renders_one :button, AtomicDesign::Atoms::Button
        
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
end

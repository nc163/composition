# frozen_string_literal: true

#
module Design
  module Component
    module AtomicDesign
      module Molecules
        class Table::Tfoot < Component
        
          # == Slots
          renders_one :trow, Table::Trow
        
          # == Attributes
          attr_accessor :row
        
          def call
            content_tag :thead, attributes do
              if content?
                concat trow
              else
                concat with_trow(row: row)
              end
            end
          end
        
        end
      end
    end
  end
end

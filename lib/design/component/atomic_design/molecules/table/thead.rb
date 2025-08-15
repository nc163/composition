# frozen_string_literal: true

#
module Design
  module Component
    module AtomicDesign
      module Molecules
        class Table::Thead < Component
        
          # == Slots
          renders_one :trow, Table::Trow
        
          # == Methods
        
          def call
            content_tag :thead, attributes do
              if content?
                concat trow
              else
                concat with_trow(context, head: true)
              end
            end
          end
        
        end
      end
    end
  end
end

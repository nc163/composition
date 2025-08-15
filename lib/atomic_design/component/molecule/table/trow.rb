# frozen_string_literal: true

#
module AtomicDesign
  module Component

      module Molecule
        class Table::Trow < Component
        
          # == Slots
          renders_many :tds, Table::Trow::Td
          renders_many :ths, Table::Trow::Th
        
          # == Attributes
          attr_accessor :head
        
          # == Methods
        
          def call
            content_tag :tr, attributes do
              if content?
                tds.each do |td|
                  concat td
                end
                ths.each do |th|
                  concat th
                end
              else
                (context || []).each do |item|
                  if head
                    concat with_th(item[0], **item[1])
                  else
                    concat with_td(item[0], **item[1])
                  end
                end
              end
            end
          end
        
        end
      end
  end
end

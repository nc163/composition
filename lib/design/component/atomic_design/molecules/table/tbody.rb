# frozen_string_literal: true

#
module Design
  module Component
    module AtomicDesign
      module Molecules
        class Table::Tbody < Component
        
          # == Slots
          renders_many :trows, Table::Trow
        
          # == Methods
          # attr_accessor :rows
        
          def call
            content_tag :tbody, attributes do
              if content?
                trows.each do |trow|
                  concat trow
                end
              else
                (context || []).each do |row|
                  concat with_trow(row, head: false)
                end
              end
            end
          end
        
        end
      end
    end
  end
end

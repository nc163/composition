# frozen_string_literal: true

#
module AtomicDesign
  module Component

      module Molecule
        class List <  Component
        
          # == Layout
          default_layout class: 'list-group list-group-flush'
        
          # == Slots
          renders_many :items, List::Item
        
          # == Methods
        
          def call
            content_tag :ol, attributes do
              if content?
                items.each do |item|
                  concat item
                end
              else
                (context || []).each do |c, o|
                  concat(with_item(c, **o))
                end
              end
            end
          end
        
        end
      end
  end
end
# frozen_string_literal: true

#
module AtomicDesign
  module Component

      module Molecule
        class ListPreview < ViewComponent::Preview
        
          # @!group default
        
          def context
            render List.new LIST
          end
        
          def block
            render List.new do |list|
              LIST.each do |item|
                list.with_item do
                  content_tag(:span, item[0], class: 'row', **item[1])
                end
              end
            end
          end
        
          private
        
          LIST = [
            ['item1', {  }],
            ['item2', {  }],
            ['item3', {  }],
            ['item4', {  }],
            ['item5', {  }]
          ]
        
        end
      end
  end
end
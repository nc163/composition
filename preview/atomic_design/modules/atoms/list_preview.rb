# frozen_string_literal: true

module AtomicDesign
  module Modules
    module Atoms
      class ListPreview < Preview # :nodoc:
        # @!group default

        # @param order select :order
        def context(order: true)
          render atomic_design.atoms.list LIST, order?: order
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

        def order
          [true, false]
        end

        LIST = [
          ['item1', {}],
          ['item2', {}],
          ['item3', {}],
          ['item4', {}],
          ['item5', {}]
        ]
      end
    end
  end
end

# frozen_string_literal: true

module AtomicDesign
  module Modules
    module Atoms
      class List < Base # :nodoc:
        renders_many :items, 'Item'

        attrs class: 'list-group list-group-flush'
        prop :order?, default: false

        class Item < Base # :nodoc:
          # == Layout
          attrs class: 'list-group-item'
        end
      end
    end
  end
end

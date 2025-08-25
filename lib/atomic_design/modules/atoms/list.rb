# frozen_string_literal: true

module AtomicDesign
  module Modules
    module Atoms
      class List < Base # :nodoc:
        renders_many :items, 'Item'

        defaults class: 'list-group list-group-flush'
        state :order?, default: false

        class Item < Base # :nodoc:
          # == Layout
          defaults class: 'list-group-item'
        end
      end
    end
  end
end

# frozen_string_literal: true

module AtomicDesign
  module Modules
    module Atoms
      class List < ::AtomicDesign::Base # :nodoc:
        renders_many :items, Item

        attributes class: 'list-group list-group-flush'
        prop :order?, default: false

        class Item < ::AtomicDesign::Base # :nodoc:
          # == Layout
          attributes class: 'list-group-item'

          # == Methods
          def call
            content_tag :li, attributes do
              context
            end
          end
        end
      end
    end
  end
end

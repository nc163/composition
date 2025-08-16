# frozen_string_literal: true

#
module AtomicDesign
  module Component
    module Molecule
      class Table::Tfoot < ::AtomicDesign::Component::Base
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

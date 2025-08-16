# frozen_string_literal: true

#
module AtomicDesign
  module Components
    module Molecules # :nodoc:
      class Table::Tfoot < ::AtomicDesign::Components::Base
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

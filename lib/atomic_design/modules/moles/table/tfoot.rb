# frozen_string_literal: true

module AtomicDesign
  module Modules
    module Moles
      class Table::Tfoot < ::AtomicDesign::Modules::Base # :nodoc:
        # == Slots
        renders_one :trow, Table::Trow

        # == Attributes
        attr_accessor :row

        def call
          content_tag :thead, options do
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

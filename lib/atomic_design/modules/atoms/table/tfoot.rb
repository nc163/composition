# frozen_string_literal: true

module AtomicDesign
  module Modules
    module Atoms
      class Table::Tfoot < Base # :nodoc:
        renders_one :trow, Table::Trow

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

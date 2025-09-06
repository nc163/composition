# frozen_string_literal: true

module AtomicDesign
  module Modules
    module Atoms
      class Table::Colgroup < Base # :nodoc:
        renders_many :cols, Table::Colgroup::Col

        def call
          content_tag :colgroup, options do
            cols.each do |col|
              concat with_col
            end
          end
        end
      end
    end
  end
end

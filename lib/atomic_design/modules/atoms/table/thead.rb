# frozen_string_literal: true

module AtomicDesign
  module Modules
    module Atoms
      class Table::Thead < Base # :nodoc:
        renders_one :trow, Table::Trow

        def call
          content_tag :thead, options do
            if content?
              concat trow
            else
              concat with_trow(context, head: true)
            end
          end
        end
      end
    end
  end
end

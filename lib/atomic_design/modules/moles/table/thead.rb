# frozen_string_literal: true

module AtomicDesign
  module Modules
    module Moles
      class Table::Thead < Base # :nodoc:
        # == Slots
        renders_one :trow, Table::Trow

        # == Methods

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

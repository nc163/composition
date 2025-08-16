# frozen_string_literal: true

#
module AtomicDesign
  module Components
    module Molecules # :nodoc:
      class Table::Thead < ::AtomicDesign::Components::Base
        # == Slots
        renders_one :trow, Table::Trow

        # == Methods

        def call
          content_tag :thead, attributes do
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

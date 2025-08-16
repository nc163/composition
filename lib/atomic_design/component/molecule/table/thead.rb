# frozen_string_literal: true

#
module AtomicDesign
  module Component
    module Molecule
      class Table::Thead < ::AtomicDesign::Component::Base
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

# frozen_string_literal: true

#
module AtomicDesign
  module Components
    module Molecules # :nodoc:
      class Table::Trow::Th < ::AtomicDesign::Components::Base
        # == Slots
        # renders_one :button, AtomicDesign::Components::Atoms::Button

        # attr_accessor :text

        # == Methods

        def call
          content_tag :th, attributes do
            if content?
              content
            else
              context
            end
          end
        end
      end
    end
  end
end

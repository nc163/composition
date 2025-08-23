# frozen_string_literal: true

#
module AtomicDesign
  module Modules
    module Moles # :nodoc:
      class Table::Trow::Th < ::AtomicDesign::Modules::Base
        # == Slots
        # renders_one :button, AtomicDesign::Modules::Atoms::Button

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

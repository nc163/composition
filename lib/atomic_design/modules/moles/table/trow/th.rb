# frozen_string_literal: true

module AtomicDesign
  module Modules
    module Moles
      class Table::Trow::Th < ::AtomicDesign::Modules::Base # :nodoc:
        # == Slots
        # renders_one :button, AtomicDesign::Modules::Atoms::Button

        # attr_accessor :text

        # == Methods

        def call
          content_tag :th, options do
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

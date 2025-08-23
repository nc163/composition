# frozen_string_literal: true

module AtomicDesign
  module Modules
    module Moles # :nodoc:
      class Table < ::AtomicDesign::Modules::Base
        # == Layout
        default_layout class: 'table'

        # == Slots
        renders_one :thead,   Table::Thead
        renders_one :tbody,   Table::Tbody

        # == Attributes
        attr_accessor :headers, :caption

        # == Methods

        def call
          content_tag :table, attributes do
            concat(content_tag(:caption, caption)) if !!caption
            if content?
              concat thead
              concat tbody
            else
              concat with_thead(headers)
              concat with_tbody(context)
            end
          end
        end
      end
    end
  end
end

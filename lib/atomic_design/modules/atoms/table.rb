# frozen_string_literal: true

module AtomicDesign
  module Modules
    module Atoms
      class Table < Base # :nodoc:
        renders_one :thead,   Table::Thead
        renders_one :tbody,   Table::Tbody

        attrs class: 'table'

        # == Attributes
        # attr_accessor :headers, :caption

        # == Methods

        def call
          content_tag :table, options do
            # concat(content_tag(:caption, caption)) if !!caption
            if content?
              concat(thead) if thead?
              concat(tbody) if tbody?
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

# frozen_string_literal: true

module AtomicDesign
  module Modules
    module Atoms
      class Table::Trow::Td < Base # :nodoc:
        def call
          content_tag :td, options do
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

# frozen_string_literal: true

module AtomicDesign
  module Modules
    module Atoms
      class Table::Caption < Base # :nodoc:
        def call
          content_tag :caption, options do
            content || context
          end
        end
      end
    end
  end
end

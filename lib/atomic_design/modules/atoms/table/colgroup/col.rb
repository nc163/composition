# frozen_string_literal: true

module AtomicDesign
  module Modules
    module Atoms
      class Table::Colgroup::Col < Base # :nodoc:
        def call
          content_tag :col, nil, options
        end
      end
    end
  end
end

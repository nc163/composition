# frozen_string_literal: true

module AtomicDesign
  module Modules
    module Atoms
      class Table < Base # :nodoc:
        renders_one :caption,   Table::Caption
        renders_one :colgroup,  Table::Colgroup
        renders_one :head,      Table::Thead
        renders_one :body,      Table::Tbody

        basic class: "table"
        state :headers
        state :caption

        def call
          content_tag :table, options do
            concat with_caption
            concat with_colgroup
            concat with_head(state(:headers)) if state(:headers)
            concat with_body(context)
          end
        end
      end
    end
  end
end

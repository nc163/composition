# frozen_string_literal: true

class Table < ApplicationComponent
  renders_one :caption,   Table::Caption
  renders_one :colgroup,  Table::Colgroup
  renders_one :head,      Table::Thead
  renders_one :body,      Table::Tbody

  state :basic, { class: "table" }
  # context :head, [ :headers ]
  # context :body, [ :table ]

  def call
    # content_tag :table, html_options do
    content_tag :table, options do
      concat with_caption
      concat with_colgroup
      concat with_head
      concat with_body if state?(:table)
    end
  end
end

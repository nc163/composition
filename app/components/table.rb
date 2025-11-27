# frozen_string_literal: true

class Table < ApplicationComponent
  renders_one :caption,   Table::Caption
  renders_one :colgroup,  Table::Colgroup
  renders_one :head,      Table::Thead
  renders_one :body,      Table::Tbody

  const :basic, { class: "table" }, to: :html_options
  context :head, [ :headers ]
  context :body, [ :table, :headers ]

  def call
    content_tag :table, options do
      concat caption if caption?
      concat colgroup if colgroup?
      concat head if head?
      concat body if body?
    end
  end
end

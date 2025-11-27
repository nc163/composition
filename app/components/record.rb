# frozen_string_literal: true

class Record < ApplicationComponent
  renders_one :caption,   Table::Caption
  renders_one :colgroup,  Table::Colgroup
  renders_one :head,      Table::Thead
  renders_one :body,      Table::Tbody

  basic class: "table"
  state :headers, to: nil
  state :caption, to: nil

  def call
    content_tag :table, html_options do
      concat with(:caption)
      concat with(:colgroup)
      # concat with(:head) if prop(:headers)
      # concat with(:body) if context
    end
  end
end

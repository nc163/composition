# frozen_string_literal: true

class Table::Colgroup::Col < ApplicationComponent # :nodoc:
  def call
    content_tag :col, nil, options
  end
end

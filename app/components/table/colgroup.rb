# frozen_string_literal: true

class Table::Colgroup < ApplicationComponent # :nodoc:
  renders_many :cols, Table::Colgroup::Col

  def call
    content_tag :colgroup, options do
      cols.each do |col|
        concat with_col
      end
    end
  end
end

# frozen_string_literal: true

class Table::Tfoot < ApplicationComponent # :nodoc:
  renders_one :trow, Table::Trow

  attr_accessor :row

  def call
    content_tag :thead, options do
      if content?
        concat trow
      else
        concat with_trow(row: row)
      end
    end
  end
end

# frozen_string_literal: true

class Table::Thead < ApplicationComponent # :nodoc:
  renders_one :trow, Table::Trow

  state :headers

  def call
    content_tag :thead, options do
      if content?
        concat trow
      else
        concat with_trow(headers, head: true)
      end
    end
  end
end

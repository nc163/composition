# frozen_string_literal: true

class Table::Thead < ApplicationComponent # :nodoc:
  renders_one :trow, Table::Trow

  effect :headers

  def call
    content_tag :thead, options do
      if content?
        concat trow
      else
        concat with_trow(items: headers, header?: true)
      end
    end
  end
end

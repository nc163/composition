# frozen_string_literal: true

class Table::Trow::Th < ApplicationComponent # :nodoc:
  def call
    content_tag :th, options do
      if content?
        content
      else
        context
      end
    end
  end
end

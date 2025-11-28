# frozen_string_literal: true

class Table::Trow::Th < ApplicationComponent # :nodoc:
  effect :value

  def call
    content_tag :th, options do
      content? ? content : value
    end
  end
end

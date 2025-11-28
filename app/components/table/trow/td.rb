# frozen_string_literal: true

class Table::Trow::Td < ApplicationComponent # :nodoc:
  effect :value

  def call
    content_tag :td, options do
      content? ? content : value
    end
  end
end

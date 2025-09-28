# frozen_string_literal: true

class Table::Trow::Td < ApplicationComponent # :nodoc:
  def call
    content_tag :td, options do
      content if content?
    end
  end
end

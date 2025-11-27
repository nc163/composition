# frozen_string_literal: true

class Table::Trow::Td < ApplicationComponent # :nodoc:
  state :value, to: nil

  def call
    content_tag :td, options do
      content? ? content : property(:value)
    end
  end
end

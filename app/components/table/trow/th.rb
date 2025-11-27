# frozen_string_literal: true

class Table::Trow::Th < ApplicationComponent # :nodoc:
  state :value, to: nil

  def call
    content_tag :th, options do
      content? ? content : property(:value)
    end
  end
end

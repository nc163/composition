# frozen_string_literal: true

class Table::Tbody < ApplicationComponent # :nodoc:
  renders_many :trows, Table::Trow

  state :table

  def call
    content_tag :tbody, options do
      table.each do |row|
        concat with_trow(row, header?: false)
      end
      # if content?
      #   trows.each do |trow|
      #     concat trow
      #   end
      # else
      #   table.each do |row|
      #     concat with_trow(row, header?: false)
      #   end
      # end
    end
  end
end

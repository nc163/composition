# frozen_string_literal: true

class Table::Tbody < ApplicationComponent # :nodoc:
  renders_many :trows, Table::Trow

  effect :table
  effect :headers

  def call
    content_tag :tbody, options do
      table.each do |row|
        items = if row.is_a?(Array)
                  row
        elsif property?(:headers)
                  headers.map { |header| row.public_send(header) }
        else
                  [ row ]
        end
        concat with_trow(items: items, header?: false)
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

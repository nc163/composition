# frozen_string_literal: true

class Table::Trow < ApplicationComponent # :nodoc:
  renders_many :tds, Table::Trow::Td
  renders_many :ths, Table::Trow::Th

  state :header?, default: false, to: nil
  state :items, default: [], to: nil

  def call
    content_tag :tr, options do
      if content?
        tds.each do |td|
          concat td
        end
        ths.each do |th|
          concat th
        end
      else
        property(:items).each do |item|
          if property(:header?)
            concat with_th(value: item)
          else
            concat with_td(value: item)
          end
        end
      end
    end
  end
end

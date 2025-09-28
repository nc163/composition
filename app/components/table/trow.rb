# frozen_string_literal: true

class Table::Trow < ApplicationComponent # :nodoc:
  renders_many :tds, Table::Trow::Td
  renders_many :ths, Table::Trow::Th

  state :header?, default: false

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
        # (context || []).each do |item|
        #   if state(:header?)
        #     concat with_th(item)
        #   else
        #     concat with_td(item)
        #   end
        # end
      end
    end
  end
end

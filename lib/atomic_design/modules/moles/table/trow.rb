# frozen_string_literal: true

module AtomicDesign
  module Modules
    module Moles
      class Table::Trow < ::AtomicDesign::Modules::Base # :nodoc:
        # == Slots
        renders_many :tds, Table::Trow::Td
        renders_many :ths, Table::Trow::Th

        # == Attributes
        attr_accessor :head

        # == Methods

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
              (context || []).each do |item|
                if head
                  concat with_th(item[0], **item[1])
                else
                  concat with_td(item[0], **item[1])
                end
              end
            end
          end
        end
      end
    end
  end
end

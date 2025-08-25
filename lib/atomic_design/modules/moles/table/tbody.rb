# frozen_string_literal: true

module AtomicDesign
  module Modules
    module Moles
      class Table::Tbody < Base # :nodoc:
        # == Slots
        renders_many :trows, Table::Trow

        # == Methods
        # attr_accessor :rows

        def call
          content_tag :tbody, options do
            if content?
              trows.each do |trow|
                concat trow
              end
            else
              (context || []).each do |row|
                concat with_trow(row, head: false)
              end
            end
          end
        end
      end
    end
  end
end

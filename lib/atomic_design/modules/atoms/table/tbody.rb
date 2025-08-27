# frozen_string_literal: true

module AtomicDesign
  module Modules
    module Atoms
      class Table::Tbody < Base # :nodoc:
        renders_many :trows, Table::Trow

        def call
          content_tag :tbody, options do
            if content?
              trows.each do |trow|
                concat trow
              end
            else
              (context || []).each do |row|
                concat with_trow(row, header?: false)
              end
            end
          end
        end
      end
    end
  end
end

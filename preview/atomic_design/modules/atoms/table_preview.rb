# frozen_string_literal: true

module AtomicDesign
  module Modules
    module Atoms
      class TablePreview < Preview # :nodoc:
        # @!group default

        # @param caption
        def context(caption: 'caption')
          render Table.new TABLE, caption: caption, headers: HEADERS
        end

        # @param caption
        def block(caption: 'caption')
          render Table.new caption: caption do |table|
            table.with_thead do |head|
              head.with_trow do |trow|
                HEADERS.each do |element|
                  trow.with_th(element[0], **element[1])
                end
              end
            end
            table.with_tbody do |body|
              TABLE.each do |record|
                body.with_trow do |row|
                  record.each do |col|
                    row.with_td(col[0], **col[1])
                  end
                end
              end
            end
          end
        end

        private

        HEADERS = [['header1', {}], ['header2', {}], ['header3', {}], ['header4', {}], ['header5', {}]]
        TABLE = [
          [['1-1', {}], ['1-2', {}], ['1-3', {}], ['1-4', {}], ['1-5', {}]],
          [['2-1', {}], ['2-2', {}], ['2-3', {}], ['2-4', {}], ['2-5', {}]],
          [['3-1', {}], ['3-2', {}], ['3-3', {}], ['3-4', {}], ['3-5', {}]],
          [['4-1', {}], ['4-2', {}], ['4-3', {}], ['4-4', {}], ['4-5', {}]]
        ]
      end
    end
  end
end

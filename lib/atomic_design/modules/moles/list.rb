# frozen_string_literal: true

module AtomicDesign
  module Modules
    module Moles
      class List < Modules # :nodoc:
        renders_many :items, List::Item

        # == Layout
        attributes class: 'list-group list-group-flush'

        def call
          content_tag :ol, attributes do
            if content?
              items.each do |item|
                concat item
              end
            else
              (context || []).each do |c, o|
                concat(with_item(c, **o))
              end
            end
          end
        end
      end
    end
  end
end

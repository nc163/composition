# frozen_string_literal: true

module AtomicDesign
  module Modules
    module Atoms
      class Table::Trow::Td < Base # :nodoc:
        # == Slots
        renders_one :button, Atoms::Button

        attr_accessor :url_options

        # == Methods

        def call
          content_tag :td, options do
            if content?
              content
            elsif url_options.present?
              concat link_to(context, url_options)
            else
              context
            end
          end
        end
      end
    end
  end
end

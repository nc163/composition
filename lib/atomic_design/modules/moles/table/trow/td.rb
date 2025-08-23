# frozen_string_literal: true

#
module AtomicDesign
  module Modules
    module Moles # :nodoc:
      class Table::Trow::Td < ::AtomicDesign::Base
        # == Slots
        renders_one :button, Atoms::Button

        attr_accessor :url_options

        # == Methods

        def call
          content_tag :td, attributes do
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

# frozen_string_literal: true

#
module AtomicDesign
  module Components
    module Molecules # :nodoc:
      class Card::Foot < ::AtomicDesign::Components::Base
        # == Layout
        default_layout class: 'card-footer'

        # == Methods

        def call
          content_tag :footer, attributes do
            content
          end
        end
      end
    end
  end
end

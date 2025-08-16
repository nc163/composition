# frozen_string_literal: true

#
module AtomicDesign
  module Components
    module Molecules # :nodoc:
      class Card::Head < ::AtomicDesign::Components::Base
        # == Layout
        default_layout class: 'card-header fw-bold'

        # == Attributes
        #

        # == Methods

        def call
          content_tag :header, attributes do
            if content?
              content
            else
              context
            end
          end
        end
      end
    end
  end
end

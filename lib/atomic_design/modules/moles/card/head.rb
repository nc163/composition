# frozen_string_literal: true

#
module AtomicDesign
  module Modules
    module Moles # :nodoc:
      class Card::Head < ::AtomicDesign::Modules::Base
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

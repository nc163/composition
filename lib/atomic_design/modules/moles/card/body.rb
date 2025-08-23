# frozen_string_literal: true

#
module AtomicDesign
  module Modules
    module Moles # :nodoc:
      class Card::Body < ::AtomicDesign::Modules::Base
        # == Layout
        default_layout class: 'card-body'

        # == Attributes
        # Nop

        # == Methods

        def call
          content_tag :div, attributes do
            concat(content || context)
          end
        end
      end
    end
  end
end

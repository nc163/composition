# frozen_string_literal: true

#
module AtomicDesign
  module Component
    module Molecule
      class Card::Body < ::AtomicDesign::Component::Base
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

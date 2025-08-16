# frozen_string_literal: true

#
module AtomicDesign
  module Component
    module Organism
      class Dialogs::Alert < ::AtomicDesign::Component::Base
        # == Constants
        # Nop

        # == Layout
        default_layout class: 'alert'

        # ==== Color
        # property_color primary: { class: 'alert-primary' }
        # property_color secondary: { class: 'alert-secondary' }
        # property_color success: { class: 'alert-success' }
        # property_color danger: { class: 'alert-danger' }
        # property_color warning: { class: 'alert-warning' }
        # property_color info: { class: 'alert-info' }

        # == Slots
        # Nop

        # == Attributes
        attr_reader :href, :target, :rel

        # == Methods

        def call
          link_to href, attributes do
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

# frozen_string_literal: true

#
module AtomicDesign
  module Component
    module Molecule
      class Metadata::Field < ::AtomicDesign::Component::Base
        # == property
        property :color, primary: { class: 'text-primary' },
                         secondary: { class: 'text-secondary' },
                         success: { class: 'text-success' },
                         danger: { class: 'text-danger' },
                         warning: { class: 'text-warning' },
                         info: { class: 'text-info' }

        # == Slots
        renders_one :icon, AtomicDesign::Component::Atom::Icon::FontAwesome6
        renders_one :text, AtomicDesign::Component::Atom::Text::Plane
        renders_one :label, AtomicDesign::Component::Atom::Text::Label

        # == Methods

        def call
          content_tag :div, attributes do
            if content?
              concat label if label?
              (content_tag :p do
                concat(icon) if icon?
                concat(text) if text?
              end)
            else
              concat context
            end
          end
        end
      end
    end
  end
end

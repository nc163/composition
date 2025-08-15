# frozen_string_literal: true

#
module AtomicDesign
  module Component

      module Molecule
        module Field
          class State < Component
          
            # == Layout
            default_layout class: 'form-group'
          
            # == Slots
            renders_one :badge, AtomicDesign::Atom::Metadata::Badge
          
            # == Attributes
            #
          
            # == Methods
          
            def call
              content_tag :div, attributes do
                concat content_tag(:label, title, class: 'field-state__title')
                concat content_tag(:p, state, class: "field-state_#{state}")
              end
            end
          
          end
        end
      end
  end
end

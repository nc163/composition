# frozen_string_literal: true

#
module AtomicDesign
  module Components
    module Molecules # :nodoc:
      module Field
        class Text < ::AtomicDesign::Components::Base
          # == Layout
          default_layout class: 'form-group'

          # == Slots
          #

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

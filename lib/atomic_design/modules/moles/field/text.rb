# frozen_string_literal: true

#
module AtomicDesign
  module Modules
    module Moles # :nodoc:
      module Field
        class Text < Base # :nodoc:
          # == Layout
          attrs class: 'form-group'

          # == Slots
          #

          # == Attributes
          #

          # == Methods

          def call
            content_tag :div, options do
              concat content_tag(:label, title, class: 'field-state__title')
              concat content_tag(:p, state, class: "field-state_#{state}")
            end
          end
        end
      end
    end
  end
end

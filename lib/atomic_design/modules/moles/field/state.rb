# frozen_string_literal: true

#
module AtomicDesign
  module Modules
    module Moles # :nodoc:
      module Field
        class State < ::AtomicDesign::Modules::Base
          # == Layout
          default_layout class: 'form-group'

          # == Slots
          renders_one :badge, AtomicDesign::Modules::Atoms::Metadata::Badge

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

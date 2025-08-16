# frozen_string_literal: true

#
module AtomicDesign
  module Component
    module Atom
      module Form
        class Select < ::AtomicDesign::Component::Base
          # == Layout
          default_layout class: 'form-group'

          # == Attributes
          # attr_accessor :placeholder

          # == Slots
          # Nop

          # == Methods

          def call
            content_tag :div, attributes do
              concat form.label(context, class: 'fw-bold')
              # concat form.select(context, form.object.select_options, class: 'form-select', use_default: true)
              concat form.select(context, options_for_select(form.object.select_options), class: 'form-select',
                                                                                          use_default: true)
            end
          end
        end
      end
    end
  end
end

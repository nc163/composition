# frozen_string_literal: true

#
module AtomicDesign
  module Component
    module Atom
      module Form
        module Confirm
          class DatetimeField < ::AtomicDesign::Component::Base
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
                concat form.datetime_field(context, class: 'form-control', use_default: true)
              end
            end
          end
        end
      end
    end
  end
end

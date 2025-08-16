# frozen_string_literal: true

#
module AtomicDesign
  module Components
    module Atoms # :nodoc:
      module Form
        module Confirm
          class DateField < ::AtomicDesign::Components::Base
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
                concat form.date_field(context, class: 'form-control', use_default: true)
              end
            end
          end
        end
      end
    end
  end
end

# frozen_string_literal: true

module AtomicDesign
  module Modules
    module Atoms
      module Forms
        module Confirms
          class TextField < ::AtomicDesign::Modules::Base # :nodoc:
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
                concat form.text_field(context, class: 'form-control', use_default: true)
              end
            end
          end
        end
      end
    end
  end
end

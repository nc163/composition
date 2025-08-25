# frozen_string_literal: true

module AtomicDesign
  module Modules
    module Atoms
      module Forms
        class TimeField < Base # :nodoc:
          # == Layout
          defaults class: 'form-group'

          # == Attributes
          # attr_accessor :placeholder

          # == Slots
          # Nop

          # == Methods

          def call
            content_tag :div, options do
              concat form.label(context, class: 'fw-bold')
              concat form.time_field(context, class: 'form-control', use_default: true)
            end
          end
        end
      end
    end
  end
end

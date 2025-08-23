# frozen_string_literal: true

#
module AtomicDesign
  module Modules
    module Atoms # :nodoc:
      module Form
        class Submit < ::AtomicDesign::Base
          # == Layout
          default_layout class: 'btn'

          property :color, primary: { class: 'btn-primary' },
                           secondary: { class: 'btn-secondary' },
                           success: { class: 'btn-success' },
                           danger: { class: 'btn-danger' },
                           warning: { class: 'btn-warning' },
                           info: { class: 'btn-info' }

          def call
            concat form.submit(context, use_default: true, **attributes)
          end
        end
      end
    end
  end
end

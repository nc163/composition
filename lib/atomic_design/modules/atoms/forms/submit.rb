# frozen_string_literal: true

module AtomicDesign
  module Modules
    module Atoms
      module Forms
        class Submit < ::AtomicDesign::Modules::Base # :nodoc:
          # == Layout
          attrs class: 'btn'

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

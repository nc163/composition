# frozen_string_literal: true

#
module Design
  module Component
    module AtomicDesign
      module Atoms
        module Form
          class Submit < Component
          
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
end

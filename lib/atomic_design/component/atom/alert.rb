# frozen_string_literal: true

# ==
module AtomicDesign
  module Component
    module Atom
      class Alert < Component

        # == Layout
        default_layout class: 'alert', role: :alert

        property :color, primary: { class: 'alert-primary' },
                         secondary: { class: 'alert-secondary' },
                         success: { class: 'alert-success' },
                         danger: { class: 'alert-danger' },
                         warning: { class: 'alert-warning' },
                         info: { class: 'alert-info' }

        # == Methods

        def call
          content_tag :div, context, attributes
        end
      end
    end
  end
end

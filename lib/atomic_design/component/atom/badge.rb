# frozen_string_literal: true

# ==
module AtomicDesign
  module Component
    module Atom
      class Badge < Component

        # == Layout
        default_layout class: 'badge'

        property :color, primary: { class: 'text-bg-primary' },
                         secondary: { class: 'text-bg-secondary' },
                         success: { class: 'text-bg-success' },
                         danger: { class: 'text-bg-danger' },
                         warning: { class: 'text-bg-warning' },
                         info: { class: 'text-bg-info' }

        # == Methods

        def call
          content_tag :mark, context, attributes
        end
      end
    end
  end
end

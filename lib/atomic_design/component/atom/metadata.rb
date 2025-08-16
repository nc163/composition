# frozen_string_literal: true

# ==
module AtomicDesign
  module Component
    module Atom
      class Metadata < ::AtomicDesign::Component::Base
        default_layout class: 'text-decoration-none'

        # == property
        property :color, primary: { class: 'text-primary' },
                         secondary: { class: 'text-secondary' },
                         success: { class: 'text-success' },
                         danger: { class: 'text-danger' },
                         warning: { class: 'text-warning' },
                         info: { class: 'text-info' }

        # == Methods
        def call
          content_to :p, context, attributes
        end
      end
    end
  end
end

# frozen_string_literal: true

module AtomicDesign
  module Modules
    module Atoms
      class Metadata < Base # :nodoc:
        attrs class: 'text-decoration-none'

        # == property
        property :color, primary: { class: 'text-primary' },
                         secondary: { class: 'text-secondary' },
                         success: { class: 'text-success' },
                         danger: { class: 'text-danger' },
                         warning: { class: 'text-warning' },
                         info: { class: 'text-info' }

        # == Methods
        def call
          content_to :p, context, options
        end
      end
    end
  end
end

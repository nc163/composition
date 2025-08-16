# frozen_string_literal: true

#
module AtomicDesign
  module Component
    module Atom
      class Text::Plane < ::AtomicDesign::Component::Base
        # == Layout
        property :color, primary: { class: 'text-bg-primary' },
                         secondary: { class: 'text-bg-secondary' },
                         success: { class: 'text-bg-success' },
                         danger: { class: 'text-bg-danger' },
                         warning: { class: 'text-bg-warning' },
                         info: { class: 'text-bg-info' }

        attr_accessor :body

        # == Methods

        def call
          content_tag :span, body, attributes
        end
      end
    end
  end
end

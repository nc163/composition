# frozen_string_literal: true

module Design
  module Component
    module AtomicDesign
      module Atoms
        class Button < Component

          default_layout class: 'btn'

          property :color, primary: { class: 'text-bg-primary' },
                           secondary: { class: 'text-bg-secondary' },
                           success: { class: 'btn-outline-success' },
                           danger: { class: 'text-bg-danger' },
                           warning: { class: 'text-bg-warning' },
                           info: { class: 'text-bg-info' }

          attr_accessor :url_options

          def call
            if !!url_options
              link_to context, url_for(url_options), attributes
            else
              content_tag :span, context, attributes
            end
          end

        end
      end
    end
  end
end

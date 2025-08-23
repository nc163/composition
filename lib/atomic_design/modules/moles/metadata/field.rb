# frozen_string_literal: true

#
module AtomicDesign
  module Modules
    module Moles # :nodoc:
      class Metadata::Field < ::AtomicDesign::Modules::Base
        # == property
        property :color, primary: { class: 'text-primary' },
                         secondary: { class: 'text-secondary' },
                         success: { class: 'text-success' },
                         danger: { class: 'text-danger' },
                         warning: { class: 'text-warning' },
                         info: { class: 'text-info' }

        # == Slots
        renders_one :icon, AtomicDesign::Modules::Atoms::Icon::FontAwesome6
        renders_one :text, AtomicDesign::Modules::Atoms::Text::Plane
        renders_one :label, AtomicDesign::Modules::Atoms::Text::Label

        # == Methods

        def call
          content_tag :div, attributes do
            if content?
              concat label if label?
              (content_tag :p do
                concat(icon) if icon?
                concat(text) if text?
              end)
            else
              concat context
            end
          end
        end
      end
    end
  end
end

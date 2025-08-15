# frozen_string_literal: true

#
module Design
  module Component
    module AtomicDesign
      module Molecules
        class Metadata::Field < Component
        
          # == property
          property :color, primary: { class: 'text-primary' },
                           secondary: { class: 'text-secondary' },
                           success: { class: 'text-success' },
                           danger: { class: 'text-danger' },
                           warning: { class: 'text-warning' },
                           info: { class: 'text-info' }
        
          # == Slots
          renders_one :icon, Design::Component::AtomicDesign::Atoms::Icon::FontAwesome6
          renders_one :text, Design::Component::AtomicDesign::Atoms::Text::Plane
          renders_one :label, Design::Component::AtomicDesign::Atoms::Text::Label
        
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
end

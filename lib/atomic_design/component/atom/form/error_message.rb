# frozen_string_literal: true

#
module AtomicDesign
  module Component
    module Atom
      module Form
        class ErrorMessage < ::AtomicDesign::Component::Base
          # == Layout
          default_layout class: ''

          def call
            return unless form.errors.any?

            content_tag :p, attributes do
              concat form.object.errors.first
            end
          end
        end
      end
    end
  end
end

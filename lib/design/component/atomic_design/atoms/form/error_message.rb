# frozen_string_literal: true

#
module Design
  module Component
    module AtomicDesign
      module Atoms
        module Form
          class ErrorMessage < Component
          
            # == Layout
            default_layout class: ''
          
            def call
              content_tag :p, attributes do
                concat form.object.errors.first
              end if form.errors.any?
            end
          end

        end
      end
    end
  end
end
# frozen_string_literal: true

module AtomicDesign
  module Modules
    module Atoms
      module Forms
        class ErrorMessage < ::AtomicDesign::Modules::Base # :nodoc:
          # == Layout
          attrs class: ''

          def call
            return unless form.errors.any?

            content_tag :p, options do
              concat form.object.errors.first
            end
          end
        end
      end
    end
  end
end

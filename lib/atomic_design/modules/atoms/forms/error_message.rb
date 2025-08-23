# frozen_string_literal: true

#
module AtomicDesign
  module Modules
    module Atoms # :nodoc:
      module Forms
        class ErrorMessage < ::AtomicDesign::Modules::Base
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

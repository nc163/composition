# frozen_string_literal: true

module AtomicDesign
  module Modules
    module Atoms
      module Forms
        class ErrorMessage < Base # :nodoc:
          # == Layout
          basic class: ""

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

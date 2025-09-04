# frozen_string_literal: true

module AtomicDesign
  module Modules
    module Atoms
      class Breadcrumb::Item < Base # :nodoc:
        # == Layout
        basic class: "list-group-item"

        # == Methods
        def call
          content_tag :li, options do
            context
          end
        end
      end
    end
  end
end

# frozen_string_literal: true

# ==
module AtomicDesign
  module Components
    module Molecules # :nodoc:
      class Dialog < ::AtomicDesign::Components::Base
        # == Methods

        def call
          content_tag :dialog, attributes do
            context || content
          end
        end
      end
    end
  end
end

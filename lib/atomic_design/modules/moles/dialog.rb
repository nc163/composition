# frozen_string_literal: true

# ==
module AtomicDesign
  module Modules
    module Moles # :nodoc:
      class Dialog < ::AtomicDesign::Base
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

# frozen_string_literal: true

module AtomicDesign
  module Modules
    module Moles
      class Dialog < ::AtomicDesign::Modules::Base # :nodoc:
        # == Methods

        def call
          content_tag :dialog, options do
            context || content
          end
        end
      end
    end
  end
end

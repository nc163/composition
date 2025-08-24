# frozen_string_literal: true

#
module AtomicDesign
  module Modules
    module Moles # :nodoc:
      class Card::Head < ::AtomicDesign::Modules::Base
        # == Layout
        attrs class: 'card-header fw-bold'

        def call
          content_tag :header, options do
            if content?
              content
            else
              context
            end
          end
        end
      end
    end
  end
end

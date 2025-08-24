# frozen_string_literal: true

#
module AtomicDesign
  module Modules
    module Moles # :nodoc:
      class Card::Body < ::AtomicDesign::Modules::Base
        # == Layout
        attrs class: 'card-body'

        def call
          content_tag :div, options do
            concat(content || context)
          end
        end
      end
    end
  end
end

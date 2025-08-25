# frozen_string_literal: true

module AtomicDesign
  module Modules
    module Moles
      class Card < Base # :nodoc:
        renders_one :head, Head
        renders_one :body, Body
        renders_one :foot, Foot

        # == Layout
        attrs class: 'card'

        def call
          content_tag :aside, options do
            if content?
              concat(head) if head?
              concat(body) if body?
              concat(foot) if foot?
            else
              concat with_body(context)
            end
          end
        end
      end
    end
  end
end

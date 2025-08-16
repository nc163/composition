# frozen_string_literal: true

module AtomicDesign
  module Components
    module Molecules # :nodoc:
      # ==
      class Card < ::AtomicDesign::Components::Base
        # == Layout
        default_layout class: 'card'

        # == Slots
        # renders_one :head, Card::Head
        # renders_one :body, Card::Body
        # renders_one :foot, Card::Foot
        # renders_one :head, -> (context = nil, options = {}, &block) do
        #   Card::Head.new(context, options, &block)
        # end
        # renders_one :body, -> (context = nil, options = {}, &block) do
        #   Card::Body.new(context, options, &block)
        # end
        renders_one :head, lambda_slots_component_handler(Card::Head)
        renders_one :body, lambda_slots_component_handler(Card::Body)
        renders_one :foot, lambda_slots_component_handler(Card::Foot)

        attr_accessor :url_option

        # == Methods

        def call
          content_tag :aside, attributes do
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

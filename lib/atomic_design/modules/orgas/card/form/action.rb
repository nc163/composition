# frozen_string_literal: true

#
module AtomicDesign
  module Modules
    module Orgas # :nodoc:
      module Card
        module Form
          class Action < ::AtomicDesign::Modules::Base
            # == Layout
            default_layout class: 'card'

            # == Slots
            renders_one :card, lambda_slots_component_handler(AtomicDesign::Modules::Moles::Card)
            renders_many :buttons, AtomicDesign::Modules::Atoms::Button

            # == Attributes
            attr_accessor :actions

            # == Methods

            def call
              with_card attributes do |card|
                if content?
                  concat context
                else
                  concat(card.with_body do
                    (actions || []).each do |context, options|
                      options = options.merge(class: 'me-2')
                      concat(with_button(context, options))
                    end
                  end)
                end
              end
            end
          end
        end
      end
    end
  end
end

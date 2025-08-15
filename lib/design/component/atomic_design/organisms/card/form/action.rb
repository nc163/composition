# frozen_string_literal: true

#
module Design
  module Component
    module AtomicDesign
      module Organisms
        module Card 
          module Form
            class Action < Component
            
              # == Layout
              default_layout class: 'card'
            
              # == Slots
              renders_one :card, lambda_slots_component_handler(AtomicDesign::Molecules::Card)
              renders_many :buttons, AtomicDesign::Atoms::Button
            
              # == Attributes
              attr_accessor :actions
            
              # == Methods
            
              def call
                with_card attributes do |card|
                  if content?
                    concat context
                  else
                    concat card.with_body {
                      (actions || []).each do |context, options|
                        options = options.merge(class: 'me-2')
                        concat(with_button(context, options))
                      end
                    }
                  end
                end
              end
            
            end
          end
        end
      end
    end
  end
end

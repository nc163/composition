# frozen_string_literal: true

#
module AtomicDesign
  module Components
    module Organisms # :nodoc:
      module Layouts
        class Sidebar < Organisms::Components
          # == Layout
          default_layout class: 'sidebar'

          # == Slots
          renders_one :card, lambda_slots_component_handler(AtomicDesign::Components::Molecules::Card)
          renders_one :list, lambda_slots_component_handler(AtomicDesign::Components::Molecules::List)
          renders_many :fields, lambda_slots_component_handler(AtomicDesign::Components::Molecules::Field)
          renders_many :badges, lambda_slots_component_handler(AtomicDesign::Components::Atoms::Badge)

          # == Methods

          def call
            # with_card attributes do |card|
            content_tag :aside, attributes do
              if content?
                # items.each_with_index do |item, index|
                #   concat item
                # end
              else
                concat(with_list do |list|
                  context.each do |_context, _options, _badge|
                    concat(list.with_item(nil, **_options) do |item|
                      concat(_context)

                      if _badge
                        badge_context, badge_options = _badge
                        concat(with_badge(badge_context, **badge_options))
                      end
                    end)
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

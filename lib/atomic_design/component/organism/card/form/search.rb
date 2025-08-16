# frozen_string_literal: true

#
module AtomicDesign
  module Component
    module Organism
      module Card
        module Form
          class Search < ::AtomicDesign::Component::Base
            # == Layout
            default_layout class: 'card'

            # == Slots
            renders_one :head,  AtomicDesign::Component::Molecule::Card::Head
            renders_one :body,  AtomicDesign::Component::Molecule::Card::Body
            renders_one :foot,  AtomicDesign::Component::Molecule::Card::Foot
            renders_many :buttons, AtomicDesign::Component::Atom::Button

            # # == Attributes

            # == Methods

            def call
              form_with model: context, url: url_for, method: :get do |form|
                content_tag :aside, attributes do
                  if content?
                    concat head
                    concat body
                    concat foot
                  else
                    concat with_head('検索')
                    concat(with_body do
                      form.object.class.attribute_types.each do |name, model_type|
                        concat form.any_field(model_type.type, name.to_sym)
                      end
                    end)
                    concat(with_foot do
                      concat form.submit('確認', color: :primary, class: 'me-2')
                      concat link_to('リセット', url_for, class: 'btn text-bg-danger me-2', method: :get)
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
end

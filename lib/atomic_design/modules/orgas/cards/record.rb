# frozen_string_literal: true

module AtomicDesign
  module Modules
    module Orgas
      module Cards
        class Record < Base # :nodoc:
          # == Layout
          basic class: "card"

          # == Slots
          renders_one :head,  AtomicDesign::Modules::Moles::Card::Head
          renders_one :body,  AtomicDesign::Modules::Moles::Card::Body
          renders_one :foot,  AtomicDesign::Modules::Moles::Card::Foot
          renders_many :buttons, AtomicDesign::Modules::Atoms::Button

          # == Attributes
          #

          # == Methods

          def call
            form_with model: context, url: url_for(action: :create), method: :post do |form|
              content_tag :aside, attributes do
                if content?
                  concat head
                  concat body
                  concat foot
                else
                  concat with_head("新規作成")
                  concat(with_body do
                    form.object.class.attribute_types.each do |name, model_type|
                      concat form.any_field(model_type.type, name.to_sym)
                    end
                  end)
                  concat(with_foot do
                    concat form.submit("確認", color: :primary)
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

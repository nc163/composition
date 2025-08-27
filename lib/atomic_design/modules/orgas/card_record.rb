# frozen_string_literal: true

# render Orgas::Card::Record.new @user, only: [:name, :email], except: nil
module AtomicDesign
  module Modules
    module Orgas
      class CardRecord < Base # :nodoc:
        # == Slots
        renders_one :card, lambda_slots_component_handler(Moles::Card)
        renders_many :fields, lambda_slots_component_handler(Moles::Field)
        renders_many :tables, lambda_slots_component_handler(Atoms::Table)
        renders_many :buttons, lambda_slots_component_handler(Atoms::Button)

        attr_accessor :only, :except, :refarences, :actions

        # == Methods

        def call
          with_card attributes do |card|
            raise ArgumentError, 'Content is not allowed in this component' if content?

            concat(card.with_head do
              "#{context.model_name.human} 詳細"
            end)
            concat(card.with_body do |body|
              record_attributes(only: only, except: except).each do |attribute|
                concat(with_field(context, field: attribute))
              end
              # refarences&.each do |refarence|
              #   refarences_table(refarence).each do |attribute|
              #     concat(with_table(context, field: attribute))
              #   end
              # end
            end)
            concat(card.with_foot do |foot|
              (actions || []).each do |context, options|
                options = options.merge(class: 'me-2')
                concat(with_button(context, options))
              end
            end)
          end
        end

        private

        def record_attributes(only: nil, except: nil)
          @table_attributes ||= only || context.attribute_names.map(&:to_sym)
          @table_attributes -= except if except.present?
          @table_attributes
        end

        def refarences_table(refarence: nil)
          refarence
        end

        # def context_for_field(resource, field_name)
        #   {
        #     title: { body: resource.class.human_attribute_name(field_name) },
        #     body: { body: resource.format_attribute(field_name) }
        #   }
        # end
      end
    end
  end
end

# frozen_string_literal: true

module AtomicDesign
  module Modules
    module Orgas
      class CardTable < ::AtomicDesign::Modules::Base # :nodoc:
        # == Slots
        renders_one :card, lambda_slots_component_handler(AtomicDesign::Modules::Moles::Card)
        renders_one :table, lambda_slots_component_handler(AtomicDesign::Modules::Moles::Table)
        renders_one :pagination, lambda_slots_component_handler(AtomicDesign::Modules::Atoms::Pagination)

        # == Attributes
        attr_accessor :only, :except

        # == Methods

        def call
          with_card attributes do |card|
            raise if content?

            concat card.with_head("#{context.model_name.human} 一覧")
            concat(card.with_body do
              concat with_table(context_for_table, options_for_table)
            end)
            concat card.with_foot(class: 'd-flex justify-content-center') {
              concat with_pagination(context, {})
            }
          end
        end

        private

        def options_for_table
          @options_for_table_headers ||= table_attributes.map do |attribute|
            [context.human_attribute_name(attribute), {}]
          end
          { headers: @options_for_table_headers }
        end

        def table_attributes
          @table_attributes ||= only || context.attribute_names.map(&:to_sym)
          @table_attributes -= except if except.present?
          @table_attributes
        end

        def context_for_table # (resources, only: nil, except: nil, caption: nil, url_for: nil, resource_path: nil)
          # attributes = filtered_attributes(resources, only:, except:)
          #
          # # == セルの生成
          # # - リソースへのPathの指定がされている場合は、専用のセルを追加する
          # # ヘッダーセルのパラメーター
          # headers = attributes.map { |attribute| resources.human_attribute_name(attribute) }
          # headers << '-' if url_for.present? && url_for.class == Proc

          # ボディーセルのパラメーター
          @context_for_table = context.map do |resource|
            body = table_attributes.map { |attribute| [resource.format_attribute(attribute), {}] }
            body << ['詳細', { url_options: url_for(resource) }]
            body
          end
        end
      end
    end
  end
end

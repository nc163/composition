# frozen_string_literal: true

module Design
  module Component
    module Example
      # すべてのコンポーネントの基底クラス
      class BaseComponent < ViewComponent::Base
        # 共通のヘルパーメソッドやロジックをここに定義

        private

        # CSSクラスを結合するヘルパー
        def class_names(*classes)
          classes.compact.reject(&:empty?).join(" ")
        end

        # データ属性を生成するヘルパー
        def data_attributes(data = {})
          data.transform_keys { |key| "data-#{key.to_s.dasherize}" }
        end

        # HTML属性をマージするヘルパー
        def merge_attributes(defaults = {}, overrides = {})
          merged = defaults.merge(overrides)

          # classの特別な処理
          if defaults[:class] && overrides[:class]
            merged[:class] = class_names(defaults[:class], overrides[:class])
          end

          merged
        end
      end
    end
  end
end
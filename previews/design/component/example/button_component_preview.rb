# frozen_string_literal: true

# ボタンコンポーネントのプレビュー
module Design
  module Component
    module Example
      class ButtonComponentPreview < ViewComponent::Preview
        # @label デフォルト
        def default
          render ButtonComponent.new do
            "クリックしてください"
          end
        end
      
        # @label バリアント
        def variants
          render_with_template
        end
      
        # @label サイズ
        def sizes
          render_with_template
        end
      
        # @label 無効状態
        def disabled
          render ButtonComponent.new(disabled: true) do
            "無効なボタン"
          end
        end
      
        # @label カスタム属性
        def with_custom_attributes
          render ButtonComponent.new(
            variant: "primary",
            id: "custom-button",
            "data-action": "click->controller#action"
          ) do
            "カスタムボタン"
          end
        end
      end
    end
  end
end
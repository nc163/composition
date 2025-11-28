# frozen_string_literal: true

module Composition
  module Properties
    module Effectable
      extend ActiveSupport::Concern

      module ClassMethods
        # コンポーネントの内部状態（副作用）を定義する
        # HTMLオプションには展開されず、コンポーネント内部でのみ使用する値を保持する
        #
        # @param name [Symbol] プロパティ名
        # @param options [Object] オプション（バリデーションや変換ロジックなど）
        # @param default [Object] デフォルト値
        # @param required [Boolean] 必須かどうか
        #
        # @example
        #   effect :order?, default: false
        #   effect :status, { open: 1, closed: 0 }, default: :open
        def effect(name, options = nil, default: nil, required: false)
          def_property Effect.new(
            name: name.to_sym,
            params: options,
            default: default,
            required: required,
            to: nil,
          )

          # 定義された名前でprivateメソッドを作成する
          unless method_defined?(name)
            define_method(name) do
              property(name)
            end
            private name
          end
        end
      end
    end
  end
end

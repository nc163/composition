# frozen_string_literal: true

module Composition # :nodoc:
  module Modules
    module Constable
      extend ActiveSupport::Concern

      module ClassMethods # :nodoc:
        # 定数プロパティを定義する
        # 変更されない固定値や、デフォルトのHTML属性などを定義する場合に使用する
        #
        # @param name [Symbol] プロパティ名
        # @param options [Object] 定数値
        # @param default [Object] デフォルト値（optionsと同じ扱い）
        # @param required [Boolean] 必須かどうか
        # @param to [Symbol] 値の展開先（例: :html_options）
        #
        # @example
        #   const :basic, { class: "table" }, to: :html_options
        def const(name, options = nil, default: nil, required: false, to: nil)
          def_property Const.new(
            name: name.to_sym,
            params: options,
            default: default,
            required: required,
            to: to,
          )
        end
      end
    end
  end
end

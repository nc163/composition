# frozen_string_literal: true

module Composition # :nodoc:
  module Properties
    module Statable
      extend ActiveSupport::Concern

      module ClassMethods # :nodoc:
        # コンポーネントの状態を定義する
        #
        # @param name [Symbol] プロパティ名
        # @param options [Object] オプション（バリデーションや変換ロジックなど）
        # @param default [Object] デフォルト値
        # @param required [Boolean] 必須かどうか
        # @param to [Symbol] 値の展開先（例: :html でHTML属性として展開）
        #
        # @example
        #   state :title, default: 'Hello World'
        #   state :color, COLORS, default: :primary, to: :html
        #   state :time, ->(time) { "#{((Time.zone.now - time) / 3600).floor}時間前" }
        def state(name, options = nil, default: nil, required: false, to: :html_options, **kwargs)
          if options.nil? && kwargs.present?
            options = kwargs
          end

          def_property State.new(
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

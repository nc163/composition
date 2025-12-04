# frozen_string_literal: true

module Composition # :nodoc:
  module Properties
    module Styleable
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
        def style(*arg, **kwargs)
          options = arg.first if arg.length == 1
          name, options = arg if arg.length == 2
          elsif arg.length == 1
            options = arg.first
            name = SecureRandom.hex(8).to_sym
          elsif arg.length == 0
            raise ArgumentError, "位置引数がない場合は例外"
          else
            options = nil
            name = SecureRandom.hex(8).to_sym
          end

          default = kwargs[:default]
          required = kwargs[:required] || false
          to = kwargs[:to]
          
          if options.nil? && kwargs.present?
            options = kwargs
          end

          def_property Style.new(
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

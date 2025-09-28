# frozen_string_literal: true

module FunctionalView
  # FunctionalView コンポーネント基底クラス
  class Component < ::ViewComponent::Base
    include Property

    def initialize(*args, **kwargs, &block)
      args.unshift nil if block_given?

      @args = args
      @kwargs = kwargs
    end

    def options
      options = []
      options = html_options if respond_to?(:html_options)
      options = options + [ without_property(**@kwargs) ]
      options.flatten.compact.reduce { _1.merge(_2, &method(:merge_to_html_options)) }
    end

    private

    # 色々なHTML属性のマージを頑張る
    def merge_to_html_options(key, old_value, new_value)
      raise ArgumentError, "Key must be a Symbol" unless key.is_a?(Symbol)

      case key
      when :id, :class
        [ old_value, new_value ].compact.join(" ")
      when :style
        [ old_value, new_value ].compact.join("; ")
      when :data, :arel
        old_value.to_h.merge(new_value.to_h)
      else
        [ old_value, new_value ].compact.join(" ")
      end
    end
  end
end

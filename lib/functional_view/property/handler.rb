# frozen_string_literal: true

require "forwardable"

module FunctionalView
  module Property
    class Handler
      attr_accessor :register
      extend Forwardable
      def_delegator :register, :all, :functions

      def initialize(register:)
        @register = register
      end

      def build(**kwargs)
        # required のものが揃っているか確認する
        missing_required = functions.select(&:required?).map(&:name) - kwargs.keys
        raise ArgumentError, "Missing required properties: #{missing_required.join(', ')}" if missing_required.any?

        @kwargs = kwargs
      end

      def state(name)
        register.resolve(name, @kwargs[name])
      end

      # HTML属性をまとめて取得する
      def html_options
        html_options = []

        html_functions = functions.select { |h| h.to == :html }
        html_options << html_functions.map { |f| f.call(@kwargs[f.name]) }

        # kwargs のうち、property以外を抽出
        property_names = functions.map(&:name)
        html_options << @kwargs.reject { |k, _| property_names.include?(k) }

        # 展開
        html_options.flatten.compact.reduce { _1.merge(_2, &method(:merge_html_attributes)) }
      end

      private

      # 色々なHTML属性のマージを頑張る
      def merge_html_attributes(key, old_value, new_value)
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
end

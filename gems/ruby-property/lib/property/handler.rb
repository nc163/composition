# frozen_string_literal: true

require "forwardable"

module Property
  #
  class Handler
    attr_accessor :register, :resolver, :dispacher
    extend Forwardable
    def_delegator :register, :all, :property_all
    def_delegator :register, :list, :property_list
    def_delegator :register, :exist?, :property_exists?
    def_delegator :resolver, :resolve, :property_resolve
    def_delegator :dispacher, :dispatch_to_html, :property_dispatch

    def initialize(register:, resolver:, dispacher:)
      @register = register
      @resolver = resolver
      @dispacher = dispacher
    end

    def dispatch(**kwargs)
      # required のものが揃っているか確認する
      missing_required = property_all.select(&:required?).map(&:name) - kwargs.keys
      raise ArgumentError, "Missing required properties: #{missing_required.join(', ')}" if missing_required.any?

      @kwargs = kwargs
    end

    # HTML属性をまとめて取得する
    def html_options
      html_options = []

      # kwargs にない、propertyを抽出
      html_properties = property_all.select { |h| h.to == :html }
      html_properties_without_kwargs = html_properties.reject { |h| @kwargs.key?(h.name) }
      html_options << html_properties_without_kwargs.map { |a| property_resolve(a.name) }

      # kwargs のうち、propertyを抽出
      property_kwargs = @kwargs.select { |k, _| html_properties.map(&:name).include?(k) }# { |k, _| property_exists?(k) }
      property_html_kwargs = property_kwargs.select { |k, v| property_dispatch(k) }
      html_options << property_html_kwargs.map { |k, v| property_resolve(k, v) }

      # kwargs のうち、property以外を抽出
      property_names = property_all.map(&:name)
      html_options << @kwargs.reject { |k, _| property_names.include?(k) }

      # 展開
      html_options.flatten.compact.reduce { _1.merge(_2, &method(:merge_html_attributes)) }
    end

    # プロパティがメソッドとして呼び出し可能か判定する
    def invokable?(name)
      property_exists?(name)
    end

    # プロパティの値を呼び出す
    def invoke(name)
      property_resolve(name, @kwargs[name])
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

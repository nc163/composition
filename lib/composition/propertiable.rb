# frozen_string_literal: true

require "forwardable"

module Composition
  module Propertiable
    extend ActiveSupport::Concern
    include Util

    included do
      @property_set ||= PropertySet.new

      prepend Initialization
    end

    attr_accessor :function_resolver

    module Initialization
      def initialize(*args, **kwargs, &block)
        # puts "Propertiable#initialize: #{self.class.name}, kwargs=#{kwargs.keys}"
        missing_required = property_set.select(&:required?).pluck(:name) - kwargs.keys
        raise ArgumentError, "Missing required properties: #{missing_required.join(', ')}" if missing_required.any?

        @function_resolver ||= Resolver.new(property_set, kwargs)
        return unless defined?(super)

        if method(__method__).super_method.arity.zero?
          super()
        else
          super
        end
      end
    end

    include Properties

    module ClassMethods # :nodoc:
      attr_accessor :property_set

      def inherited(subclass)
        super
        subclass.instance_variable_set(:@property_set, property_set.clone)
      end

      def property
        property_set.pluck(:name)
      end

      def def_property(property)
        raise unless property.is_a?(Properties::Base)

        property_set.append property
        define_property_access_method property
      end

      private

      def define_property_access_method(property)
        return unless method_type = property.to

        define_method(method_type) do
          function_resolver.access_resolve(method_type)
        end unless method_defined?(method_type)
      end
    end

    # プロパティの値を取得する
    # 引数がない場合は、定義されているプロパティ名の配列を返す
    #
    # @param property_name [Symbol, String, nil] プロパティ名
    # @return [Object, Array<Symbol>] プロパティの値、またはプロパティ名の配列
    def property(property_name = nil)
      return self.class.property if property_name.nil?

      function_resolver.action_resolve(property_name)
    end

    # プロパティが存在するかどうかを判定する
    #
    # @param property_name [Symbol, String] プロパティ名
    # @return [Boolean] プロパティが存在する場合はtrue
    def property?(property_name)
      !!function_resolver.action_resolve(property_name)
    end

    #
    def property_set
      self.class.property_set
    end

    # 定義されていないプロパティ（余剰な引数）を取得する
    # HTML属性などをそのままタグに渡す場合に利用する
    #
    # @return [Hash] 定義外のプロパティのハッシュ
    def without_property
      function_resolver.without_property
    end
  end
end

# frozen_string_literal: true

require "forwardable"

module Property
  module Functions
    extend ActiveSupport::Autoload

    eager_autoload do
      # Class
      autoload :Basic
      autoload :Context
      autoload :Effect
      autoload :State
    end

    extend ActiveSupport::Concern

    included do
      @property_register ||= Property::Register.new
      # class_attribute :property_register, default: Property::Register.new
    end

    module ClassMethods # :nodoc:
      def inherited(klass)
        super
        klass.instance_variable_set(:@property_register, @property_register.clone)
      end

      attr_accessor :property_register

      def properties
        @property_register.list
      end

      # 基本的なプロパティを定義する
      def basic(**options)
        def_property Property::Functions::Basic.new(name: :basic, value: options)
      end

      # 状態を定義する
      def state(name, map = nil, **options)
        if !map.nil? && map.is_a?(Array)
          def_property Property::Functions::State.new(name: name, map: map, **options)
        else
          def_property Property::Functions::State.new(name: name, **options)
        end
      end

      # effect :time, to: (time)=> { "#{((Time.zone.now - time) / 3600).floor}時間前" }
      def effect(name, **options)
        def_property Property::Functions::Effect.new(name: name, **options)
      end

      # :nodoc:
      def context(name, **options)
        def_property Property::Functions::Context.new(name: name, **options)
      end

      private

      extend ::Forwardable
      def_delegator :@property_register, :add,  :def_property
    end

    # プロパティレジスタを返す
    def property_register
      self.class.property_register
    end

  end
end

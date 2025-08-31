# frozen_string_literal: true

module AtomicDesign
  module Modules
    module Helpers
      #
      module PropertyHelpers
        extend ActiveSupport::Autoload

        EFFECTIVE_PROPERTY_TYPE = :effective
        PASSIVE_PROPERTY_TYPE = :passive

        eager_autoload do
          # Class
          autoload :Property
          autoload :Effect
          autoload :State
          # Modules
          autoload :StateHelper
          autoload :EffectHelper
          autoload :PredefinedHelper
          autoload :MethodHelper
        end

        extend ActiveSupport::Concern
        include StateHelper
        include EffectHelper
        include PredefinedHelper
        include MethodHelper

        included do
          @properties = {}

          unless instance_variable_defined?(:@property_helper_included)
            instance_variable_set(:@property_helper_included, true)
            PropertyHelpers.initializer(self)
          end
        end

        module ClassMethods
          #
          def inherited(klass)
            super
            klass.instance_variable_set(:@properties, @properties.deep_dup)
            PropertyHelpers.initializer(klass)
          end

          def properties
            @properties.keys
          end

          def get_property(property_name)
            @properties[property_name]
          end

          protected

          # プロパティの設定
          # @param name [Symbol] プロパティ名
          # @param type [EFFECTIVE_PROPERTY_TYPE|PASSIVE_PROPERTY_TYPE] プロパティタイプ
          # @param options [Hash] オプション
          def set_property(property_name, property)
            raise ArgumentError, "Invalid property name" unless !property_name.nil?
            raise ArgumentError, "Invalid property" unless !property.nil? # && property.is_a?(Property)

            @properties[property_name.to_sym] = property
          end
        end

        # initializerの設定を共通化
        def self.initializer(klass)
          initializer = Module.new do
            define_method(:initialize) do |*args, **kwargs, &block|
              @html_options = []
              property_kwargs, _ = kwargs.slice { |k, _| properties.include?(k) }
              unless property_kwargs.empty?
                property_values = property_kwargs.map { |k, v| get_property(k).get(v) }
                property_values.each do |p|
                  @html_options << p if p.function == Property::HTML_ATTRS
                end
              end

              super(*args, **kwargs, &block) if defined?(super)
            end
          end

          klass.prepend(initializer)
        end

        def html_options
          @html_options
        end
      end
    end
  end
end

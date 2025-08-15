# frozen_string_literal: true

#
module AtomicDesign
  module Component
    module Property

      PROPERTY_DEFAULT_KEYWORDS = :default

      def self.included(base)
        base.extend ClassMethods
      end

      # プリセット設定
      def set_property(name, key)
        @propertyted ||= []
        @propertyted << self.class.property_resolve(name, key)
        self
      end

      protected

      # プリセットの値を取得
      def propertyted_attributes
        @propertyted ||= []
        @propertyted
      end

      # HTML属性を配列で返す
      def to_html_attributes(html_attributes = [])
        html_attributes = super(html_attributes) if defined?(super)

        html_attributes + propertyted_attributes
      end

      #
      def partition_by(options)
        options = super(options) if defined?(super)

        properties, options = options.partition { |k, _| property_name?(k) }.map(&:to_h)
        properties.each { |k, v| set_property(k, v) }

        options
      end

      private

      # プリセットかどうか
      def property_name?(property_name)
        self.class.registted_property_name?(property_name)
      end

      #
      module ClassMethods
        # プリセット一覧
        def properties
          registry
        end

        # プリセット名
        def property_names
          registry.keys
        end

        # def inherited(child)
        #   child.instance_variable_set(:@registered_properties, @registered_properties.clone)

        #   if (super_m = method(__method__).super_method)
        #     super_m.call(child)
        #   end
        # end

        # プリセットの定義
        # @example
        #   property :color, default: :primary,
        #                  primary: { class: 'text-primary' },
        #                  secondary: { class: 'text-secondary' }
        #   property :size, small: { class: 'sm' },
        #                 medium: { class: 'md' },
        #                 large: { class: 'lg' },
        #                 extra_large: { class: 'xl' }
        #
        def property(property_name, **kwargs)
          property_name_validation(property_name)

          regist_property_name(property_name)

          default_param = kwargs.delete(PROPERTY_DEFAULT_KEYWORDS) if kwargs.keys.include?(PROPERTY_DEFAULT_KEYWORDS)
          regist_property_default(property_name, default_param) if default_param
          kwargs.each do |key, values|
            regist_property_params(property_name, key, values)
          end
        rescue StandardError => e
          raise e, "[#{self}] Failed to define property. #{e.message}", e.backtrace
        end

        def registted_property_name?(property_name)
          registry.keys.include?(property_name)
        end

        def property_resolve(property_name, property_key)
          registry[property_name][property_key]
        end

        protected

        #
        def to_options_for_self(options = [])
          options = super(options) if defined?(super)

          options << properties.reduce({}) { |r, (k, v)| { k => v.keys } }
        end


        private

        def registry
          @registered_properties ||= {}
        end

        # regist_property_params :color
        def regist_property_name(property_name)
          @registered_properties[property_name] = {}

          method_name = property_name.to_s.pluralize
          # e.g. method_name = "colors"
          # Component.colors
          #   => [:primary, :secondary, :success]
          define_singleton_method(method_name) do
            registry[property_name].keys
          end
        end

        # regist_property_default :color, :primary
        def regist_property_default(property_name, default_key)
          registry[property_name][PROPERTY_DEFAULT_KEYWORDS] = default_key
        end

        # regist_property_params :color, :primary, { class: 'text-primary' }
        def regist_property_params(property_name, key, value)
          registry[property_name][key] = value
        end

        def property_name_validation(property_name)
          raise ArgumentError, "Invalid property name: #{property_name}" unless property_name.is_a?(Symbol)
          raise ArgumentError, "Invalid property name: #{property_name}" if registry.include?(property_name)
        end
      end
    end
  end
end

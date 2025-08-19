# frozen_string_literal: true

module AtomicDesign
  module Components
    # AtomicDesign コンポーネント基底クラス
    class Base2 < ViewComponent::Base
      include AtomicDesign::Modules

      INVALID_OPTIONS_KEYWORDS = %i[properties attributes].freeze

      attr_accessor :context, :options, :form

      # View Context
      #
      # Tableコンポーネントにはテーブルデータを渡すなど、決められた形式で渡すことができる
      # @example
      #   Table.new(table, id: 'any', data: {})
      #
      # 細かく制御したい場合はブロックを渡す
      # @example
      #   Table.new(id: 'any', data: {}) do |table|
      #     table.head do
      #     ...
      #
      # params [*] context_or_form_method_or_options
      # params [Hash] options
      def initialize(context_or_form_method_or_options = nil, options = {})
        super

        if block_given?
          options = context_or_form_method_or_options || {}
          context_or_form_method_or_options = nil
        end

        raise ArgumentError, 'Invalid arguments' if options.keys.any? { |k| INVALID_OPTIONS_KEYWORDS.include?(k) }

        other = partition_by_attr_accessor_for_send(options || {})
        @options = partition_by(other)
        @context = context_or_form_method_or_options
      end

      # == Class Methods

      class << self
        def options_for_self
          to_options_for_self.compact.reduce(&:merge)
        end

        protected

        # lambda slots
        # https://viewcomponent.org/guide/slots.html#lambda-slots
        def lambda_slots_component_handler(component_class)
          raise ArgumentError unless component_class < AtomicDesign::Components::Base

          proc do |context_or_form_method_or_options = nil, options = {}, &block|
            component_class.new(context_or_form_method_or_options, options, &block)
          end
        end

        private

        def to_options_for_self(options = [])
          options = super(options) if defined?(super)

          options
        end
      end

      def context?
        !!@context
      end

      def property_options(options = {})
        @property_options ||= {}
        @property_options.merge!(options)
      end

      #
      def prop_options
        # TODO: Implement prop_options
        ''
      end

      #
      def tag_options(options, escape = true)
        @builder ||= ActionView::Helpers::TagHelper::TagBuilder.new(nil)
        @builder.tag_options(options, escape)
      end

      # HTML属性を返す
      #
      # @example
      #  AnyComponents.new('hello', id: 'any', color: :primary).attributes
      #   => { id: 'any', class: 'text-primary' }
      def attributes
        html_attributes = to_html_attributes.compact
        html_attributes << @options
        html_attributes.reduce { _1.merge(_2, &method(:merge_html_attributes)) }
      end

      #
      def form_with(options = {}, &block)
        options[:class] ||= 'form'
        options[:local] ||= true
        options[:builder] ||= ::AtomicDesign::Helpers::FormHelper::AtomicDesignFormBuilder
        helpers.form_with(**options, &block)
      end

      # == Methods

      private

      # HTML属性を配列で返す
      def to_html_attributes(html_attributes = [])
        html_attributes = super(html_attributes) if defined?(super)

        html_attributes
      end

      # 使用する属性を取得、設定
      # 出力はHTML属性
      def partition_by(options)
        options = super(options) if defined?(super)
        # options = partition_by_attr_accessor_for_send(options)

        options
      end

      #
      def partition_by_attr_accessor_for_send(params)
        # context というキーワードがある場合は再起的に処理する必要がある
        context, other = params.partition { |k, _| k.to_sym == :context }.map(&:to_h)
        partition_by_attr_accessor_for_send(context) if context.any?

        attributes, other = other.partition { |k, _| respond_to?("#{k}=") }.map(&:to_h)
        attributes.each { |k, h| send("#{k}=", h) }
        other
      end

      # 色々なHTML属性のマージを頑張る
      def merge_html_attributes(key, old_value, new_value)
        raise ArgumentError, 'Key must be a Symbol' unless key.is_a?(Symbol)

        case key
        when :class
          [old_value, new_value].compact.join(' ')
        when :style
          [old_value, new_value].compact.join('; ')
        when :data
          old_value.to_h.merge(new_value.to_h)
        else raise "Invalid key: #{key}"
        end
      end
    end
  end
end

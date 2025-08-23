# frozen_string_literal: true

module AtomicDesign
  # AtomicDesign コンポーネント基底クラス
  class Base < ::ViewComponent::Base
    include ::PropStore::Helpers

    attr_accessor :context, :form

    # View Context
    #
    # Tableコンポーネントにはテーブルデータを渡すなど、決められた形式で渡すことを考慮する
    # @example
    #   Table.new table_data, id: 'any', data: {}
    #
    # 細かく制御したい場合はブロックを渡す
    # @example
    #   Table.new(id: 'any', data: {}) do |table|
    #     table.head do
    #     ...
    #
    # params [*] context_or_form_method_or_options
    # params [Hash] options
    def initialize(context_or_form_method_or_options = nil, **options)
      # super

      if block_given?
        options = context_or_form_method_or_options || {}
        context_or_form_method_or_options = nil
      end

      @context = context_or_form_method_or_options
      @options = options
    end

    class << self
      # 初期値を設定する
      def attributes(**options)
        @attributes ||= {}
        @attributes.merge!(options)
      end
    end

    def context?
      !!@context
    end

    # #
    # def form_with(options = {}, &block)
    #   options[:class] ||= 'form'
    #   options[:local] ||= true
    #   options[:builder] ||= ::AtomicDesign::Helpers::FormHelper::AtomicDesignFormBuilder
    #   helpers.form_with(**options, &block)
    # end

    protected

    # HTML属性のハッシュ
    def options
      return {} unless (@options ||= {}).any?

      prop_options = @options.keys && self.class.props
      others = @options.delete_if { |k, _| prop_options.include?(k) }

      # html attributes
      html_attrs = [] || {}
      html_attrs << others if others.any?
      html_attrs << self.class.attributes if self.class.attributes.any?
      prop_options.map { |p| send(p) || {} }.each do |h|
        html_attrs << h
      end
      html_attrs.reduce { _1.merge(_2, &method(:merge_html_attributes)) }
    end

    private

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

# frozen_string_literal: true

module AtomicDesign
  module Modules
    # AtomicDesign コンポーネント基底クラス
    class Base < ::ViewComponent::Base
      include Helpers

      attr_accessor :form

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
      # params [*] args
      # params [Hash] kwargs
      def initialize(*args, **kwargs, &block)
        # if block_given?
        #   kwargs = args || {}
        #   args = []
        # end

        @args = args
        @kwargs = kwargs
      end

      class << self
        # HTML属性の初期値
        def attrs(**options)
          @attributes ||= {}
          @attributes.merge!(options)
        end
      end

      # #
      # def form_with(options = {}, &block)
      #   options[:class] ||= 'form'
      #   options[:local] ||= true
      #   options[:builder] ||= ::AtomicDesign::Helpers::FormHelper::FormBuilder
      #   helpers.form_with(**options, &block)
      # end

      protected

      # コンテキストが存在するか
      def context?
        !!@args
      end

      # コンテキストを取得する
      def contexts
        @args
      end

      # HTML属性のハッシュ
      def options
        prop_options = @kwargs.keys && self.class.props
        others = @kwargs.delete_if { |k, _| prop_options.include?(k) }

        html_attrs = [{}]
        html_attrs << others if others.any?
        html_attrs << self.class.attrs if self.class.attrs.any?
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
        when :id
          [old_value, new_value].compact.join(' ')
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

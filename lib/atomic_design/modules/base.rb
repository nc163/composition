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
        args.unshift nil if block_given?

        @args = args
        @kwargs = kwargs
      end

      class << self
        def nesting
          namespace = name.underscore
          @nesting ||= AtomicDesign::Helpers::ModuleHelper::ModuleBuilder.new(namespace)
        end

        # 後方互換性
        def lambda_slots_component_handler(component_class)
          raise ArgumentError unless component_class < AtomicDesign::Modules::Base

          proc do |context_or_form_method_or_options = nil, options = {}, &block|
            component_class.new(context_or_form_method_or_options, options, &block)
          end
        end
      end

      # #
      # def form_with(options = {}, &block)
      #   options[:class] ||= 'form'
      #   options[:local] ||= true
      #   options[:builder] ||= ::AtomicDesign::Helpers::FormHelper::FormBuilder
      #   helpers.form_with(**options, &block)
      # end

      def nesting
        self.class.nesting
      end

      protected

      # コンテキストが存在するか
      def context?
        !context.nil?
      end

      # コンテキストを取得する
      def context
        @args&.first
      end

      # 引数を取得する
      def args
        @args || []
      end

      # HTML属性のハッシュ
      def options
        html_attrs = [{}]
        html_attrs << @kwargs.slice(*(@kwargs.keys - self.class.status))
        html_attrs << self.class.defaults if self.class.defaults.any?
        html_attrs << state_html_values
        html_attrs.flatten.reduce { _1.merge(_2, &method(:merge_html_attributes)) }
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
        else
          [old_value, new_value].compact.join(' ')
        end
      end
    end
  end
end

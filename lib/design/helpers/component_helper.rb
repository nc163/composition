# frozen_string_literal: true

# Rendering components.

module Design
  module Helpers
    module ComponentHelper

      # DSL for rendering AtomicDesignComponent based components.
      #
      # コンポーネントを呼び出すためのヘルパーメソッド
      # @param component_name [String] コンポーネント名
      # @param context_or_options [Object] コンポーネントのコンテキストまたはオプション
      # @param options [Hash] コンポーネントのオプション
      # @param block [Proc] コンポーネントのブロック
      #
      # @example
      #   component 'bulma/alert', id: 'alert', class: 'alert'
      #   => Bulma::Alert.new(id: 'alert', class: 'alert')
      #
      # AtomicDesignの場合は省略できる
      #
      # @example
      #   component 'atoms/alert', id: 'alert', class: 'alert'
      #   => AtomicDesign::Atoms::Alert.new(id: 'alert', class: 'alert')
      #
      # また、AtomicDesignの場合、**organisms**以外のコンポーネントをView呼び出すことは稀なので
      # **organisms**/以下のコンポーネントを呼び出す場合は省略できる
      #
      # @example
      #   component 'sidebar', id: 'sidebar', class: 'sidebar'
      #   => AtomicDesign::Organisms::Sidebar.new(id: 'sidebar', class: 'sidebar')
      #
      def component(component_name, context_or_options = nil, **options, &block)
        component_full_name = resolve_component_full_name(component_name, default: 'atomic_design/organisms/')
        component = component_full_name.camelize.safe_constantize

        raise "#{component_name} is not defined." if component.nil?
        raise "#{component}(#{name}) must inherit from AtomicDesignComponent." unless component < Design::Component::Base

        render component.new(context_or_options, **options), &block
      end

      # # DSL for rendering AtomicDesignComponent based form.
      # #
      # # @param options [Hash] -
      # #
      # # @example:
      # #   component 'form_with', model: @resource, url: url_for(action: :update), local: true do |slot|
      # #     slot.field :name, label: 'Name', placeholder: 'Enter your name'
      # def form_component(component_name, options = {}, **form_options, &block)
      #   form_with_component(**form_options) do |form|
      #     options[:form] = form
      #     component(component_name, **options, &block)
      #   end
      # end

      private

      # def form_with_component(options={})
      #   options[:class] ||= 'form'
      #   options[:local] ||= true
      #   options[:builder] ||= Design::Helpers::AtomicDesign::FormBuilder
      #   form_with(**options) { |f| yield f if block_given? }
      # end

      # def component_class_resolve(name, default: 'atomic_design/organisms/')
      #   component_name = ''
      #   if name.start_with?('bulma/', 'atomic_design/')
      #     component_name = name
      #   elsif name.start_with?('atoms/', 'molecules/', 'organisms/', 'templates/', 'pages/')
      #     component_name = "atomic_design/#{name}"
      #   else # デフォルト atomic_design/organisms/ 以下とする
      #     component_name = "#{default}#{name}"
      #   end
      #   component_name
      # end

      def component_name_space
        @component_name_space ||= case Design.configuration.component_design
        when :atomic_design
          "design/component/#{Design.configuration.component_design}/organisms"
        else
          "design/component/#{Design.configuration.component_design}"
        end
      end

      #
      def resolve_component_full_name(name, default: nil)
        "#{component_name_space}/#{name}"
      end

    end
  end
end

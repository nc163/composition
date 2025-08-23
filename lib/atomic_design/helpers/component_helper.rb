# frozen_string_literal: true

module AtomicDesign
  module Helpers
    module ComponentHelper # :nodoc:
      extend ActiveSupport::Concern

      class AtomicDesignComponentBuilder # :nodoc:
        def initialize(view_context)
          @view_context = view_context
        end

        class ComponentBuilder # :nodoc:
          MODULE_PATH = 'atomic_design/modules'

          def initialize(view_context, module_name)
            @view_context = view_context
            @module_name = "#{MODULE_PATH}/#{module_name}"
          end

          def build(name)
            component_string = "#{@module_name}/#{name.to_s.underscore}".camelize
            component = component_string.safe_constantize

            raise "#{component_string} is not defined." if component.nil?
            raise "#{component.name} must inherit from AtomicDesign::Base" unless component < ::AtomicDesign::Base

            component
          end

          def tag_options(options, escape = true)
            return if options.blank?

            output = +''
            sep    = ' '
            options.each_pair do |key, value|
              type = TAG_TYPES[key]
              if type == :data && value.is_a?(Hash)
                value.each_pair do |k, v|
                  next if v.nil?

                  output << sep
                  output << prefix_tag_option(key, k, v, escape)
                end
              elsif type == :aria && value.is_a?(Hash)
                value.each_pair do |k, v|
                  next if v.nil?

                  case v
                  when Array, Hash
                    tokens = TagHelper.build_tag_values(v)
                    next if tokens.none?

                    v = safe_join(tokens, ' ')
                  else
                    v = v.to_s
                  end

                  output << sep
                  output << prefix_tag_option(key, k, v, escape)
                end
              elsif type == :boolean
                if value
                  output << sep
                  output << boolean_tag_option(key)
                end
              elsif !value.nil?
                output << sep
                output << tag_option(key, value, escape)
              end
            end
            output unless output.empty?
          end

          def boolean_tag_option(key)
            %(#{key}="#{key}")
          end

          def tag_option(key, value, escape)
            case value
            when Array, Hash
              value = TagHelper.build_tag_values(value) if key.to_s == 'class'
              value = escape ? safe_join(value, ' ') : value.join(' ')
            else
              value = escape ? ERB::Util.unwrapped_html_escape(value) : value.to_s
            end
            value = value.gsub('"', '&quot;') if value.include?('"')
            %(#{key}="#{value}")
          end

          private

          def prefix_tag_option(prefix, key, value, escape)
            key = "#{prefix}-#{key.to_s.dasherize}"
            value = value.to_json unless value.is_a?(String) || value.is_a?(Symbol) || value.is_a?(BigDecimal)
            tag_option(key, value, escape)
          end

          def respond_to_missing?(*args)
            true
          end

          def method_missing(called, *args, **options, &block)
            component = build(called)
            @view_context.render component.new(*args, **options), &block
          end
        end

        def atom
          component_builder(@view_context, :atoms)
        end

        def mole
          component_builder(@view_context, :molecules)
        end

        def orga
          component_builder(@view_context, :organisms)
        end

        def temp
          component_builder(@view_context, :templates)
        end

        def page
          component_builder(@view_context, :pages)
        end

        private

        def component_builder(view_context, module_name)
          @component_builder ||= ComponentBuilder.new(view_context, module_name)
        end
      end

      # コンポーネントを返す
      # ActionView::Helpers::TagHelper.tag のような書き方をするためのヘルパー
      #
      # === Building
      #
      # 定義済みのコンポーネントを呼び出すためのコンポーネントプロクシを以下のように使う
      #
      #   atomic_design.<component_space>.<component_name>(context, options)
      #
      # component_space には atoms, molecules, organisms, templates, pages を指定できる。
      #
      # ==== Passing
      #
      # コンポーネントのコンテキストを指定することができる。
      #
      #   atomic_design.atoms.button 'ボタン'
      #   # => <button class='btn'>ボタン</button>
      #
      #   link_to atomic_design.atoms.button atomic_design.atoms.badge('リンクテキスト'), root_path
      #   # => <a href="/"><mark class='badge'>リンクテキスト</mark></a>
      #
      # ブロック式
      #
      #   link_to root_path do
      #     atomic_design.atoms.button atomic_design.atoms.badge('リンクテキスト')
      #   end
      #   # => <a href="/"><mark class='badge'>リンクテキスト</mark></a>
      #
      # === Options
      #
      # コンポーネントに渡すオプションを指定することができる。
      # 詳細はActionView::Helpers::TagHelper
      #
      #   atomic_design.atoms.button 'ボタン', id: 'btn-1'
      #   # => <button id='btn-1' class='btn'>ボタン</button>
      #
      def atomic_design
        atomic_design_component_builder
      end

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
      #   => AtomicDesign::Modules::Atoms::Alert.new(id: 'alert', class: 'alert')
      #
      # また、AtomicDesignの場合、**organisms**以外のコンポーネントをView呼び出すことは稀なので
      # **organisms**/以下のコンポーネントを呼び出す場合は省略できる
      #
      # @example
      #   component 'sidebar', id: 'sidebar', class: 'sidebar'
      #   => AtomicDesign::Orgas::Sidebar.new(id: 'sidebar', class: 'sidebar')
      #
      def component(component_name, context_or_options = nil, **options, &block)
        component = "atomic_design/component/organism/#{component_name}".camelize.safe_constantize

        raise "#{component_name} is not defined." if component.nil?
        raise "#{component}(#{name}) must inherit from AtomicDesignComponent." unless component < AtomicDesign::Base

        render component.new(context_or_options, **options), &block
      end

      private

      def atomic_design_component_builder
        @atomic_design_component_builder ||= AtomicDesignComponentBuilder.new(self)
      end
    end
  end
end

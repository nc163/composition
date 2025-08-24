# frozen_string_literal: true

module AtomicDesign
  module Helpers
    module ModuleHelper # :nodoc:
      extend ActiveSupport::Concern

      class ModuleProxy # :nodoc:
        def initialize(view_context)
          @view_context = view_context
        end

        class ModuleBuilder # :nodoc:
          MODULE_PATH = 'atomic_design/modules'

          def initialize(view_context, module_name)
            @view_context = view_context
            @module_name = "#{MODULE_PATH}/#{module_name}"
          end

          private

          def build(name)
            target_string = "#{@module_name}/#{name.to_s.underscore}".camelize
            target = target_string.safe_constantize

            raise "#{target_string} is not defined." if target.nil?

            if target&.class
              unless target < ::AtomicDesign::Modules::Base
                raise "#{target.name} must inherit from AtomicDesign::Modules::Base"
              end

              return target
            end
            raise 'テスト中' if target&.module?

            target
          end

          def respond_to_missing?(*args)
            true
          end

          def method_missing(called, *args, **options, &block)
            component = build(called)
            @view_context.render component.new(*args, **options), &block
          end
        end

        def atoms
          @atom_builder ||= builder(@view_context, :atoms)
        end

        def moles
          @mole_builder ||= builder(@view_context, :molecules)
        end

        def orgas
          @orga_builder ||= builder(@view_context, :organisms)
        end

        def temps
          @temp_builder ||= builder(@view_context, :templates)
        end

        def pages
          @page_builder ||= builder(@view_context, :pages)
        end

        private

        def builder(view_context, module_name)
          ModuleBuilder.new(view_context, module_name)
        end
      end

      # コンポーネントを返す
      # ActionView::Helpers::TagHelper.tag のような書き方をするためのヘルパー
      #
      # === Building
      #
      # 定義済みのコンポーネントを呼び出すためのコンポーネントプロクシを以下のように使う
      #
      #   atomic_design.<module>.<component_name>(context, options)
      #
      # module には atoms, moles, orgas, temps, pages
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
        module_proxy
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
        component = "atomic_design/component/orgas/#{component_name}".camelize.safe_constantize

        raise "#{component_name} is not defined." if component.nil?
        unless component < AtomicDesign::Modules::Base
          raise "#{component}(#{name}) must inherit from AtomicDesignComponent."
        end

        render component.new(context_or_options, **options), &block
      end

      private

      def module_proxy
        @module_proxy ||= ModuleProxy.new(self)
      end
    end
  end
end

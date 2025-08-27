# frozen_string_literal: true

module AtomicDesign
  module Helpers
    module ModuleHelpers # :nodoc:
      extend ActiveSupport::Autoload

      eager_autoload do
        autoload :AtomsHelpers
        autoload :MolesHelpers
        autoload :OrgasHelpers
        autoload :TempsHelpers
        autoload :PagesHelpers
      end

      extend ActiveSupport::Concern
      include AtomsHelpers
      include MolesHelpers
      include OrgasHelpers
      include TempsHelpers
      include PagesHelpers

      class ModuleBuilder # :nodoc:
        def initialize(namespace_snake_case)
          @namespace = namespace_snake_case
        end

        attr_reader :namespace

        def arbit(names_snake_case, *args, **kwargs, &block)
          klass_or_module_string = "#{namespace}/#{names_snake_case}"
          klass_or_module = klass_or_module_string.camelize.safe_constantize

          return build!(klass_or_module, *args, **kwargs, &block) if klass_or_module.is_a?(Class)
          return recall!(klass_or_module_string, *args, **kwargs, &block) if klass_or_module.is_a?(Module)

          nil
        end

        private

        def build!(cls, *args, **kwargs, &block)
          cls.new(*args, **kwargs, &block)
        end

        def recall!(mod, *args, **kwargs, &block)
          self.class.new(mod, *args, **kwargs, &block)
        end

        def respond_to_missing?(*args)
          true
        end

        def method_missing(called, *args, **kwargs, &block)
          res = arbit(called, *args, **kwargs, &block)
          return res unless res.nil?

          super(called, *args, **kwargs)
        end
      end

      class ModuleProxy # :nodoc:
        MODULES_PATH = 'atomic_design/modules'

        # Returns the atoms modules
        def atoms
          @atoms ||= builder(:atoms)
        end

        # Returns the molecules modules
        def moles
          @moles ||= builder(:moles)
        end

        # Returns the organisms modules
        def orgas
          @orgas ||= builder(:orgas)
        end

        # Returns the templates modules
        def temps
          @temps ||= builder(:temps)
        end

        # Returns the pages modules
        def pages
          @pages ||= builder(:pages)
        end

        private

        def builder(module_name)
          ModuleBuilder.new("#{MODULES_PATH}/#{module_name}")
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
      def component(component_name, *context_or_options, **options, &block)
        component = "atomic_design/component/orgas/#{component_name}".camelize.safe_constantize
        raise "#{component_name} is not defined." if component.nil?

        render component.new(*context_or_options, **options), &block
      end

      private

      def module_proxy
        @module_proxy ||= ModuleProxy.new
      end
    end
  end
end

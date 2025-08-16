# frozen_string_literal: true

module AtomicDesign
  # = AtomicDesign Helpers
  module Helpers
    module ComponentHelper # :nodoc:
      extend ActiveSupport::Concern

      class AtomicDesignComponentBuilder # :nodoc:
        def initialize(view_context)
          @view_context = view_context
        end

        class ComponentBuilder # :nodoc:
          def initialize(view_context, component_type)
            @view_context = view_context
            @component_type = component_type
          end

          def build(name)
            component_string = "atomic_design/component/#{@component_type}/#{name.to_s.underscore}".camelize
            component = component_string.safe_constantize

            raise "#{component_string} is not defined." if component.nil?
            unless component < AtomicDesign::Components::Base
              raise "#{component.name} must inherit from AtomicDesign::Components::Base"
            end

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

        def atoms
          component_builder(@view_context, :atoms)
        end

        def molecules
          component_builder(@view_context, :molecules)
        end

        def organisms
          component_builder(@view_context, :organisms)
        end

        def templates
          component_builder(@view_context, :templates)
        end

        def pages
          component_builder(@view_context, :pages)
        end

        private

        def component_builder(view_context, component_type)
          @component_builder ||= ComponentBuilder.new(view_context, component_type)
        end
      end

      # コンポーネントを生成する
      # atomic_design.organisms.modal(options)
      # => render AtomicDesign::Components::Organisms::Modal.new(options)
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
      #   => AtomicDesign::Components::Atom::Alert.new(id: 'alert', class: 'alert')
      #
      # また、AtomicDesignの場合、**organisms**以外のコンポーネントをView呼び出すことは稀なので
      # **organisms**/以下のコンポーネントを呼び出す場合は省略できる
      #
      # @example
      #   component 'sidebar', id: 'sidebar', class: 'sidebar'
      #   => AtomicDesign::Organisms::Sidebar.new(id: 'sidebar', class: 'sidebar')
      #
      def component(component_name, context_or_options = nil, **options, &block)
        component = "atomic_design/component/organism/#{component_name}".camelize.safe_constantize

        raise "#{component_name} is not defined." if component.nil?
        unless component < AtomicDesign::Components::Base
          raise "#{component}(#{name}) must inherit from AtomicDesignComponent."
        end

        render component.new(context_or_options, **options), &block
      end

      private

      def atomic_design_component_builder
        @atomic_design_component_builder ||= AtomicDesignComponentBuilder.new(self)
      end

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

      #
      def resolve_component_full_name(name, default: nil)
        "atomic_design/component/organisms/#{name}"
      end
    end
  end
end

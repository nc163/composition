# frozen_string_literal: true

module Composition # :nodoc:
  module Modules
    module Contextable
      extend ActiveSupport::Concern

      included do
        prepend InstanceMethods
      end

      module InstanceMethods
        def initialize(*args, **kwargs, &block)
          super
          setup_contexts(kwargs)
        end

        private

        def setup_contexts(kwargs)
          self.class.property_set.select { |p| p.type == :context }.each do |ctx|
            slot_args = {}

            # Extract values for the properties defined in the context
            Array(ctx.params).each do |prop_name|
              # Check if the property value is available in kwargs (passed by user)
              if kwargs.key?(prop_name)
                slot_args[prop_name] = kwargs[prop_name]
              # Or check if it has a default value defined in the property set (via state/property definition)
              elsif (prop = self.class.property_set.find(prop_name)) && prop.default
                 slot_args[prop_name] = prop.default
              end
            end

            # Call the slot method (e.g., with_head) if we have arguments to pass
            slot_method = "with_#{ctx.slot_name}"
            singular_slot_method = "with_#{ctx.slot_name.to_s.singularize}"

            # Check if it's a renders_many slot (implies singular method exists and is different from plural)
            is_renders_many = slot_method != singular_slot_method && respond_to?(singular_slot_method)

            if is_renders_many && slot_args.any?
              # If we have a single property that is an Array, iterate over it
              # Assuming the context definition maps one property to the collection
              if slot_args.size == 1 && slot_args.values.first.is_a?(Array)
                collection = slot_args.values.first
                collection.each do |item|
                  if item.is_a?(Hash)
                    # Convert keys to symbols to ensure they match keyword arguments
                    send(singular_slot_method, **item.symbolize_keys)
                  else
                    send(singular_slot_method, item)
                  end
                end
              end
            elsif respond_to?(slot_method) && slot_args.any?
               send(slot_method, **slot_args)
            end
          end
        end
      end

      module ClassMethods # :nodoc:
        # スロットへのプロパティ受け渡しを定義する
        # コンポーネントの初期化時に渡されたプロパティを、自動的にスロット（renders_one/renders_many）へ渡す
        #
        # @param name [Symbol] スロット名
        # @param options [Array<Symbol>] スロットへ渡すプロパティ名の配列
        # @param default [Object] デフォルト値（通常は使用しない）
        # @param required [Boolean] 必須かどうか
        # @param to [Symbol] 展開先
        #
        # @example
        #   renders_one :head, HeaderComponent
        #   renders_one :foot, FooterComponent
        #   context :head, [ :title ]
        #   context :foot, [ :note ]
        def context(name, options = nil, default: nil, required: false, to: nil)
          # 1. Define the Context property itself (metadata for slot mapping)
          def_property Context.new(
            name: name.to_sym,
            params: options,
            default: default,
            required: required,
            to: to,
          )

          # 2. Automatically define properties for the keys in options (e.g., :title)
          #    so that the component accepts them in initialize.
          #    We use 'state' (or generic property) for this.
          Array(options).each do |prop_name|
            # Avoid redefining if already defined (e.g. by explicit state :title)
            unless property_set.find(prop_name)
              # Define as a simple optional property.
              # If user wants validation/defaults, they should define `state :title` explicitly before or after.
              # Or we could allow passing options to context to configure these properties.
              # For now, simple definition.
              def_property State.new(name: prop_name, required: false)

              # Also define access method if needed, though Property.new doesn't do it by default unless 'to' is set.
              # But Propartiable usually handles access via property() method.
            end
          end
        end
      end
    end
  end
end

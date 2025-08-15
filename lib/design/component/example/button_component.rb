# frozen_string_literal: true

module Design
  module Component
    module Example
      class ButtonComponent < BaseComponent
        VARIANTS = %w[primary secondary danger success].freeze
        SIZES = %w[small medium large].freeze

        def initialize(
          variant: "primary",
          size: "medium",
          disabled: false,
          type: "button",
          **html_attributes
        )
          @variant = variant.to_s
          @size = size.to_s
          @disabled = disabled
          @type = type
          @html_attributes = html_attributes

          validate_variant!
          validate_size!
        end

        private

        attr_reader :variant, :size, :disabled, :type, :html_attributes

        def button_classes
          class_names(
            "component-button",
            "component-button--#{variant}",
            "component-button--#{size}",
            ("component-button--disabled" if disabled)
          )
        end

        def button_attributes
          base_attrs = {
            type: type,
            disabled: disabled,
            class: button_classes
          }

          merge_attributes(base_attrs, html_attributes)
        end

        def validate_variant!
          return if VARIANTS.include?(variant)

          raise ArgumentError, "Invalid variant '#{variant}'. Must be one of: #{VARIANTS.join(', ')}"
        end

        def validate_size!
          return if SIZES.include?(size)

          raise ArgumentError, "Invalid size '#{size}'. Must be one of: #{SIZES.join(', ')}"
        end
      end
    end
  end
end
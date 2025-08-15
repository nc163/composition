# frozen_string_literal: true

# https://lookbook.build/guide/components/view_component

module Design
  module Component
    module Example
    # @hidden
      class ComponentPreview < ::ViewComponent::Preview

        class_attribute :register_class

      end
    end
  end
end
# frozen_string_literal: true

# https://lookbook.build/guide/components/view_component

module AtomicDesign
  module Component
    # @hidden
    class ComponentPreview < ::ViewComponent::Preview # :nodoc:
      class_attribute :register_class
      self.register_class = nil

      def preview_class
        self.class.register_class
      end

      class << self
        def set_preview_class(klass)
          self.register_class = klass
        end
      end

      def dummy(length = 100)
        text = <<~DUMMY
          Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolo
        DUMMY
        text.slice(0, length)
      end
    end
  end
end

# frozen_string_literal: true

#
module AtomicDesign
  module Components
    module Atom
      class ButtonPreview < ::ViewComponent::Preview
        # @!group default

        # @param context
        # @param color select :color_options
        def default(context: 'Example', color: :primary)
          render Button.new(context, color: color)
        end

        def primary
          render Button.new('primary', color: :primary)
        end

        def secondary
          render Button.new('secondary', color: :secondary)
        end

        def success
          render Button.new('success', color: :success)
        end

        def danger
          render Button.new('danger', color: :danger)
        end

        def warning
          render Button.new('warning', color: :warning)
        end

        def info
          render Button.new('info', color: :info)
        end

        private

        def color_options
          { choices: Button.colors }
        end
      end
    end
  end
end

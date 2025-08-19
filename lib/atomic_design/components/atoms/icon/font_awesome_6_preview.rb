# frozen_string_literal: true

#
  module AtomicDesign
    module Components
      module Atoms
        module Icon
          class FontAwesome6Preview < ::ViewComponent::Preview
            # @!group default

            # @param icon select :color_options
            def default(icon: :question)
              render FontAwesome6.new(nil, icon: icon)
            end

            private

            def color_options
              { choices: FontAwesome6.icons }
            end
          end
        end
      end
    end
  end

# frozen_string_literal: true

#
module AtomicDesign
  module Modules
    module Atoms
      module Icon
        class FontAwesome6Preview < ::ViewComponent::Preview
          # @!group default

          # @param icon select :icons
          def default(icon: :question)
            render FontAwesome6.new(nil, icon: icon)
          end

          private

          def icons
            { choices: FontAwesome6.icons }
          end
        end
      end
    end
  end
end

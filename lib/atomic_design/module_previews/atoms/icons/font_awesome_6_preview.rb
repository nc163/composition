# frozen_string_literal: true

module AtomicDesign
  module ModulePreviews
    module Atoms
      module Icons
        class FontAwesome6Preview < Base # :nodoc:
          # @!group default

          # @param icon select :icons
          def default(icon: :question)
            render atomic_design.atoms.icons.font_awesome_6(nil, icon: icon)
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

# frozen_string_literal: true

module AtomicDesign
  module Modules
    module Atoms
      class ButtonPreview < ::AtomicDesign::Modules::Preview # :nodoc:
        # @!group colors

        # @param context
        def primary(context: 'Example')
          render atomic_design.atoms.button(context, color: :primary)
        end

        # @param context
        def secondary(context: 'Example')
          render atomic_design.atoms.button(context, color: :secondary)
        end

        # @param context
        def success(context: 'Example')
          render atomic_design.atoms.button(context, color: :success)
        end

        # @param context
        def danger(context: 'Example')
          render atomic_design.atoms.button(context, color: :danger)
        end

        # @param context
        def warning(context: 'Example')
          render atomic_design.atoms.button(context, color: :warning)
        end

        # @param context
        def info(context: 'Example')
          render atomic_design.atoms.button(context, color: :info)
        end

        # @endgroup

        private

        def colors
          { choices: Button.colors }
        end
      end
    end
  end
end

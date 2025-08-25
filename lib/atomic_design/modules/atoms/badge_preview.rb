# frozen_string_literal: true

module AtomicDesign
  module Modules
    module Atoms
      class BadgePreview < Preview # :nodoc:
        # @!group default

        # @param context
        # @param color select :colors
        def default(context: 'Example', color: :primary)
          render atomic_design.atoms.badge(context, color: color)
        end

        # @!group colors

        def primary
          render atomic_design.atoms.badge.new('primary', color: :primary)
        end

        def secondary
          render atomic_design.atoms.badge.new('secondary', color: :secondary)
        end

        def success
          render atomic_design.atoms.badge.new('success', color: :success)
        end

        def danger
          render atomic_design.atoms.badge.new('danger', color: :danger)
        end

        def warning
          render atomic_design.atoms.badge.new('warning', color: :warning)
        end

        def info
          render atomic_design.atoms.badge.new('info', color: :info)
        end

        private

        def colors
          { choices: Badge.colors }
        end
      end
    end
  end
end

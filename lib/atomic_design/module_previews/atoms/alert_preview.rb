# frozen_string_literal: true

module AtomicDesign
  module ModulePreviews
    module Atoms
      class AlertPreview < Base # :nodoc:
        # @!group default

        # @param context
        def default(context: 'Example')
          render atomic_design.atoms.alert(context)
        end

        # def primary
        #   render Alert.new('primary', level: :primary)
        # end

        # def secondary
        #   render Alert.new('secondary', level: :secondary)
        # end

        # def success
        #   render Alert.new('success', level: :success)
        # end

        # def danger
        #   render Alert.new('danger', level: :danger)
        # end

        # def warning
        #   render Alert.new('warning', level: :warning)
        # end

        # def info
        #   render Alert.new('info', level: :info)
        # end

        private

        def levels
          { choices: Alert.levels }
        end
      end
    end
  end
end

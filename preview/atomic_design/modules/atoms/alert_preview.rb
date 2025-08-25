# frozen_string_literal: true

module AtomicDesign
  module Modules
    module Atoms
      class AlertPreview < Preview # :nodoc:
        # @!group default

        # @param context
        # @param level select :levels
        def default(context: 'Example', level: :info)
          render atomic_design.atoms.alert(context, level: level)
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

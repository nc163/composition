# frozen_string_literal: true

module AtomicDesign
  module ModulePreviews
    module Atoms
      module Indicators
        class BadgePreview < Base # :nodoc:
          # @param context
          def default(context: '❗️')
            render atomic_design.atoms.indicators.badge(context)
          end

          # @!group Sizes

          # @param context
          # @param alert select :alerts
          def sm(context: '❗️', alert: :info)
            render atomic_design.atoms.indicators.badge(context, size: :sm, alert: alert)
          end

          # @param context
          # @param alert select :alerts
          def md(context: '❗️', alert: :info)
            render atomic_design.atoms.indicators.badge(context, size: :md, alert: alert)
          end

          # @param context
          # @param alert select :alerts
          def lg(context: '❗️', alert: :info)
            render atomic_design.atoms.indicators.badge(context, size: :lg, alert: alert)
          end
          # @!endgroup

          # @!group alerts

          # @param context
          # @param size select :sizes
          def info(context: '❗️', size: :md)
            render atomic_design.atoms.indicators.badge(context, alert: :info, size: size)
          end

          # @param context
          # @param size select :sizes
          def success(context: '❗️', size: :md)
            render atomic_design.atoms.indicators.badge(context, alert: :success, size: size)
          end

          # @param context
          # @param size select :sizes
          def warning(context: '❗️', size: :md)
            render atomic_design.atoms.indicators.badge(context, alert: :warning, size: size)
          end

          # @param context
          # @param size select :sizes
          def danger(context: '❗️', size: :md)
            render atomic_design.atoms.indicators.badge(context, alert: :danger, size: size)
          end

          # @!endgroup

          private

          def sizes
            { choices: Badge.sizes }
          end

          def alerts
            { choices: Badge.alerts }
          end
        end
      end
    end
  end
end

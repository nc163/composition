# frozen_string_literal: true

#
module AtomicDesign
  module Component

      module Atom
        class AlertPreview < ::ViewComponent::Preview
        
          # @!group default
        
          # @param context
          # @param color select :color_options
          def default(context: "Example", color: :primary)
            render Badge.new(context, color: color)
          end
        
          def primary
            render Badge.new('primary', color: :primary )
          end
        
          def secondary
            render Badge.new('secondary', color: :secondary)
          end
        
          def success
            render Badge.new('success', color: :success)
          end
        
          def danger
            render Badge.new('danger', color: :danger)
          end
        
          def warning
            render Badge.new('warning', color: :warning)
          end
        
          def info
            render Badge.new('info', color: :info)
          end
        
          private
        
          def color_options
            { choices: Badge.colors }
          end
        
        end
      end
  end
end

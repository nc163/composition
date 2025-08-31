# frozen_string_literal: true

module AtomicDesign
  module Modules
    module Helpers
      module PropertyHelpers
        #
        module StateHelper
          extend ActiveSupport::Concern

          # STATE_PROPERTY_TYPE = PASSIVE_PROPERTY_TYPE
          # ALLOW_STATE_OPTION_KEYS = %i[to required default].freeze
          # private_constant :STATE_PROPERTY_TYPE, :ALLOW_STATE_OPTION_KEYS

          class State < Property
            def function
              METHOD
            end

            def get_value(value)
              value
            end
          end

          module ClassMethods # :nodoc:
            #
            def state(name, **options)
              # raise ArgumentError, "Invalid state options" unless allow_state_options?(**options)

              state = State.new(**options)
              set_property(name, state)
            end

            protected

            def allow_options?(**options)
              true # (options.keys - ALLOW_STATE_OPTION_KEYS).empty?
            end
          end

          protected

          # 状態を返す
          def state(name)
            property[name][:value]
          end
        end
      end
    end
  end
end

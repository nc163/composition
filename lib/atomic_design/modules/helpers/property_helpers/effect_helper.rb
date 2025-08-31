# frozen_string_literal: true

module AtomicDesign
  module Modules
    module Helpers
      module PropertyHelpers
        module EffectHelper # :nodoc:
          extend ActiveSupport::Concern

          module ClassMethods # :nodoc:
            #
            def effect(name, **options)
              # raise ArgumentError, "Invalid effect options" unless allow_effect_options?(**options)
              #
              effect = Effect.new(**options)
              set_property(name, effect)
            end
          end
        end
      end
    end
  end
end

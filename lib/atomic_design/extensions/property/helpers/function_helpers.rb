# frozen_string_literal: true

module AtomicDesign
  module Extensions
    module Property
      module Helpers
        module FunctionHelpers
          extend ActiveSupport::Concern
          module ClassMethods # :nodoc:
            # effect :time, to: (time)=> { "#{((Time.zone.now - time) / 3600).floor}時間前" }
            # ...
            # instance = Component.new(time: time)
            # instance.time
            # # => "2025年04月26日 12:34"
            def basic(**options)
              def_property(:basic, Property::Functions::Basic.new(**options))
            end

            def state(name, **options)
              def_property(name, Property::Functions::State.new(**options))
            end

            def effect(name, **options)
              def_property(name, Property::Functions::Effect.new(**options))
            end
          end
        end
      end
    end
  end
end

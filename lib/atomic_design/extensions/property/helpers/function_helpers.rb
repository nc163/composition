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
              def_property Property::Functions::Basic.new(name: :basic, value: options)
            end

            def state(name, map = nil, **options)
              if !map.nil? && map.is_a?(Array)
                def_property Property::Functions::State.new(name: name, map: map, **options)
              else
                def_property Property::Functions::State.new(name: name, **options)
              end
            end

            def effect(name, **options)
              def_property Property::Functions::Effect.new(name: name, **options)
            end
          end
        end
      end
    end
  end
end

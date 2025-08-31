# frozen_string_literal: true

module AtomicDesign
  module Extensions
    module Property
      module Helpers
        module FunctionHelpers
          module ConstHelper
            extend ActiveSupport::Concern

            module ClassMethods # :nodoc:
              # effect :time, to: (time)=> { "#{((Time.zone.now - time) / 3600).floor}時間前" }
              # ...
              # instance = Component.new(time: time)
              # instance.time
              # # => "2025年04月26日 12:34"
              def const(**options)
                # raise ArgumentError, "Invalid effect options" unless allow_effect_options?(**options)
                def_property(:default, Property::Functions::Const.new(**options))
              end
            end
          end
        end
      end
    end
  end
end

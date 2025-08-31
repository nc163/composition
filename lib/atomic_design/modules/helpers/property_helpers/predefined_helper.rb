# frozen_string_literal: true

module AtomicDesign
  module Modules
    module Helpers
      module PropertyHelpers
        # 初期値を持たせる
        module PredefinedHelper
          extend ActiveSupport::Concern

          PREDEFINED_PROPERTY_TYPE = EFFECTIVE_PROPERTY_TYPE

          class Predefined < Property
            def value
              options = self[:options]
              options[:to]
            end
          end

          module ClassMethods # :nodoc:
            def predefined(**options)
              predefined = Predefined.new(PREDEFINED_PROPERTY_TYPE, **options)
              set_property(name, predefined)
            end
          end
        end
      end
    end
  end
end

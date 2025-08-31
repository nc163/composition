# frozen_string_literal: true

module AtomicDesign
  module Extensions
    module Property
      module Helpers
        module FunctionHelpers
          extend ActiveSupport::Autoload

          eager_autoload do
            # Modules
            autoload :StateHelper
            autoload :EffectHelper
          end

          extend ActiveSupport::Concern
          include StateHelper
          include EffectHelper
        end
      end
    end
  end
end

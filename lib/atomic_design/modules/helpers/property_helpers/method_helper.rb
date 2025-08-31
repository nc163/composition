# frozen_string_literal: true

module AtomicDesign
  module Modules
    module Helpers
      module PropertyHelpers
        #
        module MethodHelper
          extend ActiveSupport::Concern



          protected

          # 一度propのメソッドを参照、ない場合は再度method_missingを呼び出す
          def method_missing(called, *args, **kwargs, &block)
            # if self.class.properties.include?(called)
            #   return property_resolve(called, *args, **kwargs, &block)
            # end

            super(called, *args, **kwargs, &block)
          end
        end
      end
    end
  end
end

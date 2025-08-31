# frozen_string_literal: true

module AtomicDesign
  module Modules
    module Helpers
      # 初期値を持たせる
      module DefaultHelper
        extend ActiveSupport::Concern

        included do
          extend ClassMethods
        end

        module ClassMethods # :nodoc:
          def defaults(**options)
            @__atomic_design__modules__helpers__default__helper__default ||= {}
            @__atomic_design__modules__helpers__default__helper__default.merge!(options)
          end
        end
      end
    end
  end
end

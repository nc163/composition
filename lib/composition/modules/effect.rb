# frozen_string_literal: true

module Composition
  module Modules
    class Effect < Property # :nodoc:
      #
      def type
        :effect
      end

      def function(val = nil)
        case params
        when Proc
          params.call(val)
        when Hash
          params.keys.include?(val) ? params[val] : {}
        when Array
          raise NotImplementedError
        else
          val
        end
      end
    end
  end
end

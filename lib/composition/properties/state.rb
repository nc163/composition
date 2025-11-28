# frozen_string_literal: true

module Composition
  module Properties
    class State < Base # :nodoc:
      #
      def type
        :state
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

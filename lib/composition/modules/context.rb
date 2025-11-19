# frozen_string_literal: true

module Composition
  module Modules
    class Context < Property # :nodoc:
      #
      def type
        :context
      end

      def function(val = nil)
        # params.map { |v| params[val] }
        # case params
        # when Proc
        #   raise NotImplementedError
        # when Hash
        #   params.keys.include?(val) ? params[val] : {}
        # when Array
        #   raise NotImplementedError
        # else
        #   params
        # end
      end
    end
  end
end

# frozen_string_literal: true

module Composition
  module Properties
    class Const < Base # :nodoc:
      #
      def type
        :const
      end

      protected

      def function(val = nil)
        params
      end

      def default_kwargs
        {
          params: nil,
          required: false,
          default: nil,
          to: nil
        }
      end
    end
  end
end

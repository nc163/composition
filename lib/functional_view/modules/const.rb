# frozen_string_literal: true

module FunctionalView
  module Modules
    class Const < Property # :nodoc:
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

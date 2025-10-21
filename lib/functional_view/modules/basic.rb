# frozen_string_literal: true

module FunctionalView
  module Modules
    class Basic < Property # :nodoc:
      #
      def type
        :basic
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

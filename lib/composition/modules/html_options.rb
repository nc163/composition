# frozen_string_literal: true

module Composition # :nodoc:
  module Modules
    module HtmlOptions
      extend ActiveSupport::Concern

      #
      def html_options
        options = []
        options = function_resolver.access_resolve(:html_options)

        # options = options + [ without_property(**@kwargs) ]
        options.reduce { _1.merge(_2, &method(:merge_html_options)) }
      end

      private

      def merge_html_options(key, a, b)
        raise ArgumentError, "Incompatible types #{a.class} and #{b.class}" unless a.class == b.class

        case a
        when String
          (Array(a) + Array(b)).join(" ")
        when Array
          (a + b).join(" ")
        when Hash
          [ a, b ]
        end
      end
    end
  end
end

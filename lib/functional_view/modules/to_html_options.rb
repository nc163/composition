# frozen_string_literal: true

module FunctionalView # :nodoc:
  module Modules
    module ToHtmlOptions
      extend ActiveSupport::Concern

      #
      def html_options
        options = []
        options = function_resolver.access_resolve(:html_options)
        # options = options + [ without_property(**@kwargs) ]
        options.flatten.compact.reduce { _1.merge(_2, &method(:merge_to_html_options)) }
      end

      private

      # 色々なHTML属性のマージを頑張る
      def merge_to_html_options(key, old_value, new_value)
        raise ArgumentError, "Key must be a Symbol" unless key.is_a?(Symbol)

        case key
        when :id, :class
          [ old_value, new_value ].compact.join(" ")
        when :style
          [ old_value, new_value ].compact.join("; ")
        when :data, :arel
          old_value.to_h.merge(new_value.to_h)
        else
          [ old_value, new_value ].compact.join(" ")
        end
      end
    end
  end
end

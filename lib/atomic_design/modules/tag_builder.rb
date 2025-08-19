# frozen_string_literal: true

module AtomicDesign
  # = AtomicDesign Modules
  module Modules
    module TagBuilder # :nodoc:
      #
      def html_tag_options(options, escape = true)
        # @builder ||= ActionView::Helpers::TagHelper::TagBuilder.new(nil)
        # @builder.tag_options(options, escape)
      end

      #
      def property_options(options = [])
        @property_options ||= {}
        @property_options.merge!(options)
      end
    end
  end
end

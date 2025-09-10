# frozen_string_literal: true

module Property
  module Functions
    class Basic < Property::Function # :nodoc:

      def type
        :basic
      end

      protected

      def skip_option_check
        true
      end
    end
  end
end

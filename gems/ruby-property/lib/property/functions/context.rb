# frozen_string_literal: true

module Property
  module Functions
    class Context < Property::Function # :nodoc:

      def type
        :context
      end

      protected

      def skip_option_check
        true
      end
    end
  end
end

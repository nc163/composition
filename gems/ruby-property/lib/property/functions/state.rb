# frozen_string_literal: true

module Property
  module Functions
    class State < Property::Function  # :nodoc:

      attr_accessor :map

      def type
        :state
      end

      protected

      def allow_options
        [ :map ]
      end
    end
  end
end

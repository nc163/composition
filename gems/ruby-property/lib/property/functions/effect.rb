# frozen_string_literal: true

module Property
  module Functions
    class Effect < Property::Function # :nodoc:

      attr_accessor :proc

      def type
        :effect
      end

      protected

      def allow_options
        [ :proc ]
      end
    end
  end
end

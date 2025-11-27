# frozen_string_literal: true

module Composition
  module Modules
    class Context < Property # :nodoc:
      attr_reader :slot_name

      def initialize(name:, params:, **kwargs)
        super(name: name, params: params, **kwargs)
        @slot_name = name
      end

      #
      def type
        :context
      end

      def function(val = nil)
        # Context property itself doesn't hold a single value in the same way as State
        # It acts as a definition for slot mapping.
        # However, if we want to access the context definition, we can return params.
        params
      end
    end
  end
end

# frozen_string_literal: true

require "forwardable"

module AtomicDesign
  module Extensions
    module Property
      #
      class Handler
        attr_accessor :register, :resolver, :dispacher
        extend Forwardable
        def_delegator :register, :exist?, :property_exists?
        def_delegator :resolver, :resolve, :property_resolve
        def_delegator :dispacher, :dispatch, :property_dispatch

        #
        def invoke(**kwargs)
          even, odd = kwargs.partition { |k, _| property_exists?(k) }
          results = even.map { |k, v| property_resolve(k, v) }
        end

        private
      end
    end
  end
end

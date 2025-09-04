# frozen_string_literal: true

require "forwardable"
require "active_support/core_ext/object/deep_dup"

module AtomicDesign
  module Extensions
    module Property
      #
      class Dispacher
        attr_accessor :register
        extend Forwardable
        def_delegator :register, :exist?, :property_exists?
        def_delegator :register, :find, :property_find
        def_delegator :resolver, :resolve, :property_resolve

        def initialize(register:)
          @register = register
        end

        #
        def dispatch_to_html(name)
          function = property_find(name)
          case function
          in { to: :html }
            true
          else
            false
          end
        end
      end
    end
  end
end

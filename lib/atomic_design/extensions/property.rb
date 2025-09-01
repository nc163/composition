# frozen_string_literal: true

module AtomicDesign
  module Extensions
    module Property
      extend ActiveSupport::Autoload

      PROPERTY_FUNCTION_TYPES = [
        :value,
        :html
      ]

      eager_autoload do
        # Class
        autoload :Function
        autoload :Register
        autoload :Dispacher
        autoload :Resolver
        autoload :Handler
        # Module
        autoload :Functions
        autoload :Helpers
      end

      extend ::ActiveSupport::Concern
      include ::Forwardable
      include Helpers
    end
  end
end

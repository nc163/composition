# frozen_string_literal: true

module AtomicDesign
  module Extensions
    module Property
      extend ActiveSupport::Autoload

      eager_autoload do
        # Class
        autoload :Registry
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

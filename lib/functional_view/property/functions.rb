# frozen_string_literal: true

module FunctionalView
  module Property
    module Functions
      extend ActiveSupport::Autoload
      eager_autoload do
        # Class
        autoload :Prototype
        autoload :Action
        autoload :Spec
      end
    end
  end
end

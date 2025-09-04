# frozen_string_literal: true

module AtomicDesign
  module Modules
    module Orgas # :nodoc:
      extend ActiveSupport::Autoload

      eager_autoload do
        autoload :Cards
        autoload :Indicators


        if defined?(::Lookbook)

        end
      end
    end
  end
end

# frozen_string_literal: true

module AtomicDesign
  module Modules
    module Orgas # :nodoc:
      extend ActiveSupport::Autoload

      eager_autoload do
        autoload :Indicators
      end
    end
  end
end

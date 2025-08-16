# frozen_string_literal: true

module AtomicDesign
  # = AtomicDesign Helpers
  module Helpers
    extend ActiveSupport::Autoload

    eager_autoload do
      autoload :ComponentHelper
      autoload :FormHelper
    end
  end
end

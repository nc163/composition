# frozen_string_literal: true

module AtomicDesign
  # = AtomicDesign Extensions
  module Extensions
    extend ActiveSupport::Autoload

    eager_autoload do
      # Module
      autoload :Property
    end
  end
end

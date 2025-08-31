# frozen_string_literal: true

module AtomicDesign
  # = AtomicDesign Extensions
  module Extensions
    extend ActiveSupport::Autoload

    eager_autoload do
      #
      autoload :Property
      autoload :Context
    end

    extend ActiveSupport::Concern
    include Property
    include Context
  end
end

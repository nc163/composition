# frozen_string_literal: true

module AtomicDesign
  # = AtomicDesign Modules
  module Modules
    extend ActiveSupport::Autoload

    eager_autoload do
      autoload :Property
      autoload :DefaultLayout
    end

    extend ActiveSupport::Concern
    include Property
    include DefaultLayout
  end
end

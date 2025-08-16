# frozen_string_literal: true

module AtomicDesignPreview
  # = AtomicDesignPreview Components
  module Components
    extend ActiveSupport::Autoload

    eager_autoload do
      autoload :Base

      autoload :Atoms
      autoload :Molecules
      autoload :Organisms
      autoload :Templates
      autoload :Pages
    end
  end
end

# frozen_string_literal: true

module AtomicDesign
  # = AtomicDesign Helpers
  module Components
    extend ActiveSupport::Autoload

    eager_autoload do
      autoload :Base
      autoload :DefaultLayout
      autoload :Property

      autoload :Atoms
      autoload :Molecules
      autoload :Organisms
      autoload :Templates
      autoload :Pages
    end
  end
end

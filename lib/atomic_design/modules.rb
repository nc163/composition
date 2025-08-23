# frozen_string_literal: true

module AtomicDesign
  # = AtomicDesign Helpers
  module Modules
    extend ActiveSupport::Autoload

    eager_autoload do
      autoload :Atoms
      autoload :Moles
      autoload :Orgas
      autoload :Temps
      autoload :Pages
    end
  end
end

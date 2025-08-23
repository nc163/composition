# frozen_string_literal: true

module AtomicDesign
  # = AtomicDesign Helpers
  module Modules
    extend ActiveSupport::Autoload

    eager_autoload do
      autoload :Base

      autoload :Atoms
      autoload :Moles
      autoload :Orgas
      autoload :Temps
      autoload :Pages

      autoload :Helpers
    end
  end
end

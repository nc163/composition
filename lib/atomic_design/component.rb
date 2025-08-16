# frozen_string_literal: true

module AtomicDesign
  # = AtomicDesign Helpers
  module Component
    extend ActiveSupport::Autoload

    eager_autoload do
      autoload :Base

      autoload :Atom
      autoload :Molecule
      autoload :Organism
      autoload :Template
      autoload :Page
    end
  end
end

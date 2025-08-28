# frozen_string_literal: true

module AtomicDesign
  # プレビュー用
  module ModulePreviews
    extend ActiveSupport::Autoload

    eager_autoload do
      # Class
      autoload :Base
      # Module
      autoload :Atoms
      autoload :Moles
      autoload :Orgas
      autoload :Temps
      autoload :Pages
    end
  end
end

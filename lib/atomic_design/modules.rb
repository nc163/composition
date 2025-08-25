# frozen_string_literal: true

module AtomicDesign
  # 再利用可能なコンポーネント名前空間
  module Modules
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
      autoload :Helpers
    end
  end
end

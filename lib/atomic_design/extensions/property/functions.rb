# frozen_string_literal: true

module AtomicDesign
  module Extensions
    module Property
      module Functions
        extend ActiveSupport::Autoload

        eager_autoload do
          # Class
          autoload :Basic
          autoload :Effect
          autoload :State
        end
      end
    end
  end
end

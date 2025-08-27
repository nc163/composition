# frozen_string_literal: true

module AtomicDesign
  module Modules
    module Orgas
      module Users # :nodoc:
        extend ActiveSupport::Autoload

        eager_autoload do
          autoload :Media
        end
      end
    end
  end
end

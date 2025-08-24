# frozen_string_literal: true

module AtomicDesign
  module Modules
    module Orgas
      module Layouts # :nodoc:
        extend ActiveSupport::Autoload

        eager_autoload do
          autoload :Sidebar
        end
      end
    end
  end
end

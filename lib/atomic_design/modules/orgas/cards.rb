# frozen_string_literal: true

module AtomicDesign
  module Modules
    module Orgas
      module Cards # :nodoc:
        extend ActiveSupport::Autoload

        eager_autoload do
          autoload :Record
          autoload :Table
        end
      end
    end
  end
end

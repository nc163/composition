# frozen_string_literal: true

module AtomicDesign
  module Modules
    module Orgas
      module Cards # :nodoc:
        extend ActiveSupport::Autoload

        eager_autoload do
          autoload :Record
          autoload :Table
          autoload :Confirm
          autoload :Search
          autoload :Action
        end
      end
    end
  end
end

# frozen_string_literal: true

module AtomicDesign
  module Modules
    module Moles
      module Layouts # :nodoc:
        extend ActiveSupport::Autoload

        eager_autoload do
          # Class
          autoload :Header
          autoload :Footer
        end
      end
    end
  end
end

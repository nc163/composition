# frozen_string_literal: true

module AtomicDesign
  module Modules
    module Atoms
      module Maps # :nodoc:
        extend ActiveSupport::Autoload

        eager_autoload do
          # Class
          autoload :GoogleMap
          autoload :Mapbox
        end
      end
    end
  end
end

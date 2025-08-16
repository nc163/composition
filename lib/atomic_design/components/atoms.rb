# frozen_string_literal: true

module AtomicDesign
  module Components # :nodoc:
    module Atoms # :nodoc:
      extend ActiveSupport::Autoload

      eager_autoload do
        autoload :Alert
        autoload :Badge
        autoload :Button
        autoload :Metadata
        autoload :Pagination
      end
    end
  end
end

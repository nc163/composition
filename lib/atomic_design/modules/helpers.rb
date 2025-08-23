# frozen_string_literal: true

module AtomicDesign
  module Modules
    module Helpers # :nodoc:
      extend ActiveSupport::Autoload

      eager_autoload do
        autoload :PropHelper
      end

      extend ActiveSupport::Concern
      include PropHelper
    end
  end
end

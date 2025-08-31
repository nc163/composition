# frozen_string_literal: true

module AtomicDesign
  # = AtomicDesign Helpers
  module Helpers
    extend ActiveSupport::Autoload

    eager_autoload do
      #
      autoload :Components
      autoload :ModuleHelpers
      autoload :FormHelper
    end

    extend ActiveSupport::Concern
    include ModuleHelpers
    include FormHelper
  end
end

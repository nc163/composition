# frozen_string_literal: true

module AtomicDesign
  # = AtomicDesign Helpers
  module Helpers
    extend ActiveSupport::Autoload

    eager_autoload do
      autoload :ModuleHelper
      autoload :FormHelper
    end

    extend ActiveSupport::Concern
    include ModuleHelper
    include FormHelper
  end
end

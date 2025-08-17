# frozen_string_literal: true

require 'view_component'
require_relative 'atomic_design'

module Preview # :nodoc:
  module AtomicDesign
    extend ActiveSupport::Autoload

    eager_autoload do
      # autoload :Helpers
      # autoload :Components
    end
  end
end

# frozen_string_literal: true

require "view_component"
require "active_support/concern"
require "active_support/dependencies/autoload"
require_relative "atomic_design/version"

module AtomicDesign # :nodoc:
  extend ActiveSupport::Autoload

  eager_autoload do
    autoload :Extensions
    autoload :Helpers
    autoload :Modules
    autoload(:ModulePreviews) if defined?(::Lookbook)
  end

  # = AtomicDesign Configuration
  class Configuration
    def initialize; end
  end

  class << self
    def configure
      yield(configuration)
    end

    def configuration
      @configuration ||= Configuration.new
    end
  end
end

# require 'atomic_design/engine' if defined?(Rails)

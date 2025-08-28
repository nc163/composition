# frozen_string_literal: true

require 'action_view'
require 'hashie'
require 'view_component'
require_relative 'atomic_design/version'

module AtomicDesign # :nodoc:
  extend ActiveSupport::Autoload

  eager_autoload do
    autoload :Helpers
    autoload :Modules
    autoload(:ModulePreviews) if defined?(Lookbook)
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

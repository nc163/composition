# frozen_string_literal: true

require_relative 'atomic_design/version'

module AtomicDesign
  extend ActiveSupport::Autoload
  # autoload :Engine, 'atomic_design/engine'

  eager_autoload do
    autoload :Helpers
    autoload :Component
  end

  # = AtomicDesign Configuration
  class Configuration
    attr_accessor :component_design

    def initialize
      @component_design = :atomic_design
    end
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

require 'atomic_design/engine' if defined?(Rails)

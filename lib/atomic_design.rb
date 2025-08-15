# frozen_string_literal: true

require_relative "atomic_design/version"

module AtomicDesign
  autoload :Engine, "atomic_design/engine"

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

if defined?(Rails)
  require "atomic_design/engine"
end

# frozen_string_literal: true

#
module Design
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

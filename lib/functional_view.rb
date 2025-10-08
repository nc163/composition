# frozen_string_literal: true

require "active_support/concern"
require "active_support/dependencies/autoload"
require_relative "functional_view/version"

#
module FunctionalView
  extend ActiveSupport::Autoload
  eager_autoload do
    # Class
    autoload :Function
    autoload :Component
    # Module
    autoload :Helper
    autoload :Property
    autoload :Propartiable
    autoload :Resolver

    autoload :CreateState
    autoload :CreateContext
    autoload :UseHtmlOptions
  end

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

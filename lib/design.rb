# frozen_string_literal: true

require_relative "design/version"
require_relative "design/configuration"

module Design
  autoload :Engine, "design/engine"
end

if defined?(Rails)
  require "design/engine"
end

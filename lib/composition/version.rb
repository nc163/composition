# frozen_string_literal: true

module Composition
  module Version # :nodoc:
    VERSION = "0.3.0"

    def self.gem_version
      Gem::Version.new(VERSION)
    end
  end

  VERSION = Version::VERSION
end

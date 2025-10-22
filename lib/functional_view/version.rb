# frozen_string_literal: true

module FunctionalView
  module Version # :nodoc:
    VERSION = "0.2.3"

    def self.gem_version
      Gem::Version.new(VERSION)
    end
  end

  VERSION = Version::VERSION
end

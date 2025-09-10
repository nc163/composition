# frozen_string_literal: true

module Property
  module Version # :nodoc:
    VERSION = "0.2.0"

    def self.gem_version
      Gem::Version.new(VERSION)
    end
  end

  VERSION = Version::VERSION
end

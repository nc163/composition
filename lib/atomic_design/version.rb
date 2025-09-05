# frozen_string_literal: true

module AtomicDesign
  module Version # :nodoc:
    VERSION = "0.7.3"

    def self.gem_version
      Gem::Version.new(VERSION)
    end
  end

  VERSION = Version::VERSION
end

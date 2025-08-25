# frozen_string_literal: true

module AtomicDesign
  module Version # :nodoc:
    VERSION = '0.4.5'

    def self.gem_version
      Gem::Version.new(VERSION)
    end
  end

  VERSION = Version::VERSION
end

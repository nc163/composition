# frozen_string_literal: true

require 'view_component'
require_relative 'atomic_design/version'

module AtomicDesign # :nodoc:
  extend ActiveSupport::Autoload

  # Rails::Engineに登録しているので、Rails環境ではZeitwerkによって宣言時に名前解決できている
  # rspecなどZeitwerkがない環境のために、eager_autoloadしている
  eager_autoload do
    autoload :Helpers
    autoload :Component
  end

  # = AtomicDesign Configuration
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

require 'atomic_design/engine' if defined?(Rails)

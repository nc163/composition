# frozen_string_literal: true

module FunctionalView
  module Modules
    extend ActiveSupport::Autoload
    eager_autoload do
      # Module
      autoload :Context
      autoload :Contextable
      autoload :State
      autoload :Statable
      autoload :ToHtmlOptions
    end

    extend ActiveSupport::Concern
    include Contextable
    include Statable
    include ToHtmlOptions
  end
end

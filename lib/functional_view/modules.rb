# frozen_string_literal: true

module FunctionalView
  module Modules
    extend ActiveSupport::Autoload
    eager_autoload do
      # Module
      autoload :Const
      autoload :Constable
      autoload :Context
      autoload :Contextable
      autoload :State
      autoload :Statable
      # autoload :HtmlOptions
    end

    extend ActiveSupport::Concern
    include Constable
    include Contextable
    include Statable
    # include HtmlOptions
  end
end

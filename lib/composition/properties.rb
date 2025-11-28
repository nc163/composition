# frozen_string_literal: true

module Composition
  module Properties
    extend ActiveSupport::Autoload
    eager_autoload do
      # Class
      autoload :Base

      # Module
      autoload :Const
      autoload :Constable
      autoload :Context
      autoload :Contextable
      autoload :Effect
      autoload :Effectable
      autoload :State
      autoload :Statable
      # autoload :HtmlOptions
    end

    extend ActiveSupport::Concern
    include Constable
    include Contextable
    include Effectable
    include Statable
    # include HtmlOptions
  end
end

# frozen_string_literal: true

require "view_component"
require "active_support/all"

module FunctionalView
  # FunctionalView コンポーネント基底クラス
  class Component < ::ViewComponent::Base
    include Propartiable

    def initialize(*args, **kwargs, &block)
    end
  end
end

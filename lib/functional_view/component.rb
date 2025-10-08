# frozen_string_literal: true

module FunctionalView
  # FunctionalView コンポーネント基底クラス
  class Component < ::ViewComponent::Base
    include Propartiable
    include CreateState
    include CreateContext
    include UseHtmlOptions

    def initialize(*args, **kwargs, &block)
    end
  end
end

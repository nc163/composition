# frozen_string_literal: true

module FunctionalView
  # FunctionalView コンポーネント基底クラス
  class Component < ::ViewComponent::Base
    include Propartiable

    def initialize(*args, **kwargs, &block)
    end
  end
end

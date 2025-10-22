# frozen_string_literal: true

require "view_component"
require "active_support/all"

module FunctionalView
  # FunctionalView コンポーネント基底クラス
  class Component < ::ViewComponent::Base
    include Propartiable

    def initialize(*args, **kwargs, &block)
    end


    def options
      [ html_options, without_property ].reduce { _1.merge(_2, &method(:merge_html_options)) }
    end

    private

    def merge_html_options(key, a, b)
      raise ArgumentError, "Incompatible types #{a.class} and #{b.class}" unless a.class == b.class

      case a
      when String
        (Array(a) + Array(b)).join(" ")
      when Array
        (a + b).join(" ")
      when Hash
        [ a, b ]
      end
    end
  end
end

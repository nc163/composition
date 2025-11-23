# frozen_string_literal: true

require "view_component"
require "active_support/all"

module Composition
  # Composition コンポーネント基底クラス
  class Component < ::ViewComponent::Base
    include Propartiable
    include Util

    def initialize(*args, **kwargs, &block)
    end

    protected

    def default_params
      [ nil, nil, nil ]
    end

    def options
      merged_html_options = html_options.reduce({}) do |acc, h|
        acc.merge(h, &method(:merge_html_options))
      end
      [ merged_html_options, without_property ].reduce { _1.merge(_2, &method(:merge_html_options)) }
    end

    private
  end
end

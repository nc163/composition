# frozen_string_literal: true

require "view_component"
require "active_support/all"

module Composition
  # Composition コンポーネント基底クラス
  # ViewComponent::Base を継承し、プロパティ管理機能（Propertiable）を提供する
  class Component < ::ViewComponent::Base
    include Propertiable
    include Util

    protected

    def default_params
      [ nil, nil, nil ]
    end

    def options
      opts = respond_to?(:html_options) ? html_options : []
      merged_html_options = opts.reduce({}) do |acc, h|
        acc.merge(h, &method(:merge_html_options))
      end
      [ merged_html_options, without_property ].reduce { _1.merge(_2, &method(:merge_html_options)) }
    end

    private
  end
end

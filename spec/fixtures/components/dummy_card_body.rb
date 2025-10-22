# frozen_string_literal: true

require 'functional_view'

class DummyCardBody < ::FunctionalView::Component # :nodoc:
  state :basic, { class: "card-body" }, to: :html_options

  def call
    content_tag :div, options do
      concat content
    end
  end
end

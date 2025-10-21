# frozen_string_literal: true

require 'functional_view'

class DummyCardFoot < ::FunctionalView::Component # :nodoc:
  # == Layout
  state :basic, { class: "card-footer" }, to: :html_options

  def call
    content_tag :footer, html_options do
      content
    end
  end
end

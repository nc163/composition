# frozen_string_literal: true

require 'functional_view'

class DummyCardHead < ::FunctionalView::Component # :nodoc:
  const :basic, { class: "card-header fw-bold" }, to: :html_options
  state :title

  def call
    content_tag :header, options do
      content if content?
    end
  end
end

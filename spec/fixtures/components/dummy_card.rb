# frozen_string_literal: true

require 'functional_view'
require_relative 'dummy_card_head'
require_relative 'dummy_card_body'
require_relative 'dummy_card_foot'

class DummyCard < ::FunctionalView::Component # :nodoc:
  BORDER = {
    primary: { class: 'bg-primary' },
    secondary: { class: 'bg-secondary' },
    success: { class: 'btn-outline-success' },
    danger: { class: 'bg-danger' },
    warning: { class: 'bg-warning' },
    info: { class: 'bg-info' }
  }.freeze

  renders_one :head, DummyCardHead
  renders_one :body, DummyCardBody
  renders_one :foot, DummyCardFoot

  # html class: [ "card" ]
  state :border, BORDER, to: :html_options
  # context :head, [ :title ]
end

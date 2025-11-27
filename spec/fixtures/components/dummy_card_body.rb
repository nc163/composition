# frozen_string_literal: true

require 'composition'

class DummyCardBody < ::Composition::Component # :nodoc:
  state :basic, { class: "card-body" }

  def call
    content_tag :div, options do
      concat content
    end
  end
end

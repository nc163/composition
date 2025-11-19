# frozen_string_literal: true

require 'composition'

class DummyCardFoot < ::Composition::Component # :nodoc:
  # == Layout
  state :basic, { class: "card-footer" }, to: :html_options

  def call
    content_tag :footer, options do
      content
    end
  end
end

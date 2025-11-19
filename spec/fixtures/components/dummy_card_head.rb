# frozen_string_literal: true

require 'composition'

class DummyCardHead < ::Composition::Component # :nodoc:
  const :basic, { class: "card-header fw-bold" }, to: :html_options
  state :title

  def call
    content_tag :header, options do
      content if content?
    end
  end
end

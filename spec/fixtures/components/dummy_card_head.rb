# frozen_string_literal: true

require 'composition'

class DummyCardHead < ::Composition::Component # :nodoc:
  const :basic, { class: "card-header fw-bold" }, to: :html_options
  effect :title

  def call
    content_tag :header, options do
      concat property(:title) if property?(:title)
      concat content if content?
    end
  end
end

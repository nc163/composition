# frozen_string_literal: true

class Card::Body < ApplicationComponent # :nodoc:
  state :basic, { class: "card-body" }

  def call
    content_tag :div, html_options do
      concat content
    end
  end
end

# frozen_string_literal: true

class Card::Foot < ApplicationComponent # :nodoc:
  # == Layout
  state :basic, { class: "card-footer" }

  def call
    content_tag :footer, html_options do
      content
    end
  end
end

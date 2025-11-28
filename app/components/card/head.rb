# frozen_string_literal: true

class Card::Head < ApplicationComponent # :nodoc:
  state :basic, { class: "card-header fw-bold" }
  state :title

  def call
    content_tag :header, html_options do
      content if content?
    end
  end
end

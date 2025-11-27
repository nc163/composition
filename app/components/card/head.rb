# frozen_string_literal: true

class Card::Head < ApplicationComponent # :nodoc:
  state :basic, { class: "card-header fw-bold" }, to: :html_options
  state :title, to: nil

  def call
    content_tag :header, html_options do
      content if content?
    end
  end
end

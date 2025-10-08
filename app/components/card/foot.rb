# frozen_string_literal: true

class Card::Foot < ApplicationComponent # :nodoc:
  # == Layout
  state :basic, { class: "card-footer" }, to: :html_options

  def call
    content_tag :footer, html_options do
      content
    end
  end
end

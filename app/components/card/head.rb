# frozen_string_literal: true

class Card::Head < ApplicationComponent # :nodoc:
  state :basic, { class: "card-header fw-bold" }
  effect :title

  def call
    content_tag :header, title, **options
  end
end

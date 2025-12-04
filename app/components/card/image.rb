# frozen_string_literal: true

class Card::Image < ApplicationComponent # :nodoc:
  state :basic, { class: "card-body" }

  def call
    # image_tag :div, options do
    #   concat content
    # end
  end
end

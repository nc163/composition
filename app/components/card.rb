# frozen_string_literal: true

class Card < ApplicationComponent # :nodoc:
  renders_one :head, Card::Head
  renders_one :body, Card::Body
  renders_one :foot, Card::Foot
  # renders_one :image, types: {
  #   top: Card::Image,
  #   bottom: Card::Image,
  #   overlay: Card::Image
  # }

  style class: [ "card" ]
  style :color, {
    primary:   { class: %w[bg-primary text-white] },
    secondary: { class: %w[bg-secondary text-white] },
    success:   { class: %w[bg-success text-white] },
    danger:    { class: %w[bg-danger text-white] },
    warning:   { class: %w[bg-warning text-dark] },
    info:      { class: %w[bg-info text-white] }
  }

  def call
    content_tag :aside, **options do
      concat(head)
      concat(body)
      concat(foot)
    end
  end
end

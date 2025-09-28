# frozen_string_literal: true

# ボタンコンポーネント
# `<span class='btn'>{{content}}</span>`
class Button < ApplicationComponent
  COLORS = {
    primary: { class: "bg-primary" },
    secondary: { class: "bg-secondary" },
    success: { class: "btn-outline-success" },
    danger: { class: "bg-danger" },
    warning: { class: "bg-warning" },
    info: { class: "bg-info" }
  }.freeze

  state :basic, class: "btn",                                     to: :html_options
  state :color, COLORS,                       default: :primary,  to: :html_options
  state :link_to,             required: true,                     to: :link_to_options
end

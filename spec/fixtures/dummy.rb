# frozen_string_literal: true

class Dummy < ::AtomicDesign::Modules::Base
  COLORS = {
    primary: { class: 'bg-primary' },
    secondary: { class: 'bg-secondary' },
    success: { class: 'btn-outline-success' },
    danger: { class: 'bg-danger' },
    warning: { class: 'bg-warning' },
    info: { class: 'bg-info' }
  }.freeze

  attrs class: 'list-group list-group-flush'

  prop :order?, default: false
  prop :color, map: COLORS, default: :primary
end

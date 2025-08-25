# frozen_string_literal: true

# テスト用コンポーネント
class Dummy < ::AtomicDesign::Modules::Base
  COLORS = {
    primary: { class: 'bg-primary' },
    secondary: { class: 'bg-secondary' },
    success: { class: 'btn-outline-success' },
    danger: { class: 'bg-danger' },
    warning: { class: 'bg-warning' },
    info: { class: 'bg-info' }
  }.freeze

  default class: 'list-group list-group-flush'

  state :order?,                                    require: false, default: false
  state :color,  to: :attribute, mapping: COLORS,                   default: :primary

  # set_props do |s|
  #   s.prop :order?,                                    require: false, default: false
  #   s.prop :color,  to: :attribute, mapping: COLORS,                   default: :primary
  # end
end

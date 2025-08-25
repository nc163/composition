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

  SIZE = {
    big: { class: 'btn-lg' },
    small: { class: 'btn-sm' }
  }.freeze

  defaults class: 'list-group list-group-flush'

  #     key     |                        options
  #     name    |     role         |  func            | required      |   default
  state :size,        role: :html,    mapping: SIZE,                      default: :small
  state :color,       role: :html,    mapping: COLORS,  required: true
  state :src,         role: :html,                      required: true

  state :order?,      role: :value,                                       default: false
  state :title,       role: :value,                     required: true
  state :description, role: :value,                                       default: 'no description'
  state :age,         role: :value,   values: (0..150), required: true
end

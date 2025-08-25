# frozen_string_literal: true

class DummyProp
  include AtomicDesign::Modules::Helpers

  COLORS = %i[red green blue].freeze
  BGCOLOR_MAP = {
    primary: 'bg-primary',
    secondary: 'bg-secondary',
    danger: 'bg-danger',
    warning: 'bg-warning',
    info: 'bg-info'
  }.freeze

  state :title,                                                 required: true
  state :description
  state :color,       values: COLORS
  state :bgcolor,     mapping: BGCOLOR_MAP
  state :age,         values: (0..150)
  state :size,                              default: 'medium'
  state :dummy,                             default: 'no call'

  def initialize(name = nil, **kwargs)
  end

  def dummy
    'dummy'
  end
end

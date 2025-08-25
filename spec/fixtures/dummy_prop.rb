class DummyProp
  include AtomicDesign::Modules::Helpers::PropHelper

  COLORS = %i[red green blue].freeze
  BGCOLOR_MAP = {
    primary: 'bg-primary',
    secondary: 'bg-secondary',
    danger: 'bg-danger',
    warning: 'bg-warning',
    info: 'bg-info'
  }.freeze

  prop :title, required: true
  prop :description
  prop :color, values: COLORS
  prop :bgcolor, mapping: BGCOLOR_MAP
  prop :age, values: (0..150)
  prop :size, default: 'medium'
  prop :dummy, default: 'no call'

  def initialize(name = nil, **kwargs)
  end

  def dummy
    'dummy'
  end
end

class DummyPropChild1 < DummyProp
  prop :child1, default: 'i am child'

  def initialize(name = nil, **kwargs)
  end
end

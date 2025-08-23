class DummyPropChild2 < DummyProp
  prop :child2, default: 'i am child'

  def initialize(name = nil, **kwargs)
  end
end

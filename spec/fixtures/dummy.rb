class Dummy < ::AtomicDesign::Base
  layout class: 'dummy-class'
  property :logged_in?
  property :icon?
  property :color, :primary, { class: 'bg-primary' },
           :secondary, { class: 'bg-secondary' },
           :success, { class: 'bg-success' }
end

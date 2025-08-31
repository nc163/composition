# frozen_string_literal: true

require 'spec_helper'

describe AtomicDesign::Modules::Helpers::PropertyHelpers do # :nodoc:
  class Dummy
    include AtomicDesign::Modules::Helpers::PropertyHelpers

    COLORS = {
      primary: { class: 'bg-primary' },
      secondary: { class: 'bg-secondary' },
      success: { class: 'btn-outline-success' },
      danger: { class: 'bg-danger' },
      warning: { class: 'bg-warning' },
      info: { class: 'bg-info' }
    }.freeze

    # predefined { class: 'hoge' }
    state :active?, default: true
    effect :color, to: COLORS, default: :primary
  end

  class SubDummy < Dummy
  end

  it 'Dummy has a context_class' do
    expect(Dummy.properties).to eq []
  end

  it 'Dummy can access html_options' do
    expect { Dummy.new(color: :secondary).send(:html_options) }.not_to raise_error
  end

  it 'Dummy can access html_options' do
    expect { Dummy.new.send(:html_options) }.not_to raise_error
  end
end

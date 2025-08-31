# frozen_string_literal: true

require 'spec_helper'

describe AtomicDesign::Extensions::Property::Helpers do # :nodoc:
  class Dummy
    include AtomicDesign::Extensions::Property::Helpers

    COLORS = {
      primary: { class: 'bg-primary' },
      secondary: { class: 'bg-secondary' },
      success: { class: 'btn-outline-success' },
      danger: { class: 'bg-danger' },
      warning: { class: 'bg-warning' },
      info: { class: 'bg-info' }
    }.freeze

    state :title, default: true
    effect :color, to: COLORS, default: :primary
  end

  class SubDummy < Dummy
    state :size, default: true
  end

  it 'Dummy has a properties (forwardable)' do
    expect(Dummy.properties).to eq [ :title, :color ]
    expect(SubDummy.properties).to eq [ :title, :color, :size ]
  end

  it 'Dummy has a get_property (forwardable)' do
    expect(Dummy.get_property(:title)).to be_a AtomicDesign::Extensions::Property::Functions::State
    expect(Dummy.get_property(:color)).to be_a AtomicDesign::Extensions::Property::Functions::Effect
    expect(SubDummy.get_property(:title)).to be_a AtomicDesign::Extensions::Property::Functions::State
    expect(SubDummy.get_property(:color)).to be_a AtomicDesign::Extensions::Property::Functions::Effect
    expect(SubDummy.get_property(:size)).to be_a AtomicDesign::Extensions::Property::Functions::State
  end

  it 'Dummy can access html_options' do
    expect { Dummy.new(color: :secondary).send(:html_options) }.to raise_error
  end

  # it 'Dummy can access html_options' do
  #   expect { Dummy.new.send(:html_options) }.not_to raise_error
  # end
end

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

    basic id: 'dummy1'
    state :color,   map: COLORS,                      required: true,   to: :html
    state :title,                 default: true

    def initialize(*args, **kwargs, &block); end
  end

  class SubDummy < Dummy
    basic id: 'dummy-sub'
    state :size, default: true
  end

  it 'is return defined properties' do
    expect(Dummy.properties).to match_array([ :basic, :title, :color ])
    expect(SubDummy.properties).to match_array([ :basic, :title, :color, :size ])
  end

  it 'initialize' do
    expect { Dummy.new }.not_to raise_error(ArgumentError)
    expect { Dummy.new(title: 'Test Title') }.not_to raise_error(ArgumentError)
  end

  it 'is return paramas of mapping property' do
    expect(Dummy.colors).to match_array([ :primary, :secondary, :success, :danger, :warning, :info ])
  end

  it 'is raises error for missing required property params' do
    expect { Dummy.new }.to raise_error(ArgumentError)
    expect { Dummy.new(title: 'Test Title') }.to raise_error(ArgumentError)
  end

  it 'is correct property' do
    dummy = Dummy.new(class: 'dummy', color: :primary, title: 'Test Title')
    expect(dummy.html_options).to eq({ id: 'dummy1', class: 'bg-primary dummy' })
    sub = SubDummy.new(color: :secondary, title: 'Test Title')
    expect(sub.html_options).to eq({ id: 'dummy-sub', class: 'bg-secondary' })
  end

  # it 'is '

  it 'is can method' do
    dummy = Dummy.new(id: 'dummy-1', color: :primary, title: 'Test Title')
    expect(dummy.title).to eq('Test Title')
  end
end

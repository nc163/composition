# frozen_string_literal: true

require 'spec_helper'

describe AtomicDesign::Extensions::Property::Functions::State do # :nodoc:
  SIZES = {
    sm: { style: 'width: 25px; height: 25px;' },
    md: { style: 'width: 60px; height: 60px;' },
    lg: { style: 'width: 90px; height: 90px;' }
  }.freeze

  it 'initialize' do
    expect { described_class.new(name: :dummy) }.not_to raise_error
    expect { described_class.new(name: :dummy, required: true) }.not_to raise_error
    expect { described_class.new(name: :dummy, map: SIZES, required: true) }.not_to raise_error
  end

  it 'hashable' do
    state = described_class.new(name: :dummy, default: :info)
    expect(state[:name]).to eq(:dummy)
    expect(state[:default]).to eq(:info)
  end

  it 'method access' do
    state = described_class.new(name: :dummy, map: SIZES, default: :info)
    expect(state.name).to eq(:dummy)
    expect(state.map).to eq(SIZES)
    expect(state.respond_to?(:default)).to eq true
  end
end

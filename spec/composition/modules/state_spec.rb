# frozen_string_literal: true

require 'spec_helper'

describe Composition::Modules::State do # :nodoc:
  SIZES = {
    sm: { style: 'width: 25px; height: 25px;' },
    md: { style: 'width: 60px; height: 60px;' },
    lg: { style: 'width: 90px; height: 90px;' }
  }.freeze

  it 'initialize' do
    expect { described_class.new(name: :dummy) }.not_to raise_error
    expect { described_class.new(name: :dummy, required: true) }.not_to raise_error
    expect { described_class.new(name: :dummy, params: SIZES, required: true) }.not_to raise_error
  end

  it 'attributes' do
    state = described_class.new(name: :dummy, params: SIZES, default: :info)
    expect(state.name).to eq(:dummy)
    expect(state.default).to eq(:info)
  end

  it 'method access' do
    hash = described_class.new(name: :dummy, params: SIZES)
    expect(hash.action(:sm)).to eq(style: 'width: 25px; height: 25px;')

    proc = described_class.new(name: :dummy, params: ->(v) { [ v ] })
    expect(proc.action(:sm)).to eq([ :sm ])

    default = described_class.new(name: :dummy, params: SIZES, default: :sm)
    expect(default.action).to eq(style: 'width: 25px; height: 25px;')
  end
end

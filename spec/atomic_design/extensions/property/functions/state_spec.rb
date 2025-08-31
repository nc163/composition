# frozen_string_literal: true

require 'spec_helper'

describe AtomicDesign::Extensions::Property::Functions::State do # :nodoc:
  SIZES = {
    sm: { style: 'width: 25px; height: 25px;' },
    md: { style: 'width: 60px; height: 60px;' },
    lg: { style: 'width: 90px; height: 90px;' }
  }.freeze

  it 'initialize' do
    expect { described_class.new }.not_to raise_error
    expect { described_class.new(required: true) }.not_to raise_error
    expect { described_class.new(map: SIZES, required: true) }.not_to raise_error
  end

  it 'resolve' do
    state = described_class.new(default: :info)
    expect(state.call("sm")).to eq("sm")

    state = described_class.new(map: SIZES, default: :info)
    expect(state.call(:md)).to eq(SIZES[:md])
  end
end

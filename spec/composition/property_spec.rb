# frozen_string_literal: true

require 'spec_helper'

describe Composition::Property do # :nodoc:
  let(:args) {
    {
      type: :helper,
      name: :test,
      options: [],
      required: false,
      default: nil,
      to: :test_method
    }
  }

  it 'initialize' do
    expect { described_class.new }.to raise_error ArgumentError
    expect { described_class.new(**args) }.not_to raise_error
  end

  it 'required?' do
    property = described_class.new(**args)
    expect(property.required?).to be false

    property = described_class.new(**args.merge(required: true))
    expect(property.required?).to be true
  end

  it 'action' do
    property = described_class.new(**args)
    expect { property.action }.to raise_error NotImplementedError
  end
end

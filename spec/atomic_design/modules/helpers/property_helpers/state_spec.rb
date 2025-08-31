# frozen_string_literal: true

require 'spec_helper'

describe AtomicDesign::Modules::Helpers::PropertyHelpers::State do # :nodoc:
  it 'initialize' do
    expect { described_class.new }.not_to raise_error
    expect { described_class.new(required: true) }.not_to raise_error
  end

  it 'state' do
    state = described_class.new(required: true)
    state.set(:info)
    expect(state.value).to eq(:info)
  end
end

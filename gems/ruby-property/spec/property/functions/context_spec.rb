# frozen_string_literal: true

require 'spec_helper'

describe Property::Functions::Context do # :nodoc:

  it 'method access' do
    context = described_class.new(name: :dummy)
    expect(context.name).to eq(:dummy)
  end
end

# frozen_string_literal: true

require 'spec_helper'

describe AtomicDesign::Modules::Helpers::PropHelper do # :nodoc:
  let(:dummy) do
    DummyProp.new(title: 'サンプル', description: '説明', size: 'large', age: 10, color: :red, bgcolor: :primary)
  end

  it 'dynamic methods' do
    expect(dummy.title).to eq('サンプル')
    expect(dummy.description).to eq('説明')
    expect(dummy.size).to eq('large')
    expect(dummy.color).to eq(:red)
    expect(dummy.age).to eq(10)
    expect(dummy.bgcolor).to eq(DummyProp::BGCOLOR_MAP[:primary])
    expect(dummy.dummy).to eq('dummy')
  end
end

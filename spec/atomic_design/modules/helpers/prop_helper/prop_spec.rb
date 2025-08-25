# frozen_string_literal: true

require 'spec_helper'

describe AtomicDesign::Modules::Helpers::PropHelper::Prop do # :nodoc:
  it 'initialize' do
    dummy = DummyProp.new(title: 'タイトル')
    expect(dummy.title).to eq 'タイトル'
  end
  context 'dynamic methods' do
    let(:dummy) do
      DummyProp.new(title: 'サンプル', description: '説明', size: 'large', age: 10, color: :red, bgcolor: :primary)
    end

    it 'call' do
      expect(dummy.title).to eq('サンプル')
      expect(dummy.description).to eq('説明')
      expect(dummy.size).to eq('large')
      expect(dummy.color).to eq(:red)
      expect(dummy.age).to eq(10)
      expect(dummy.bgcolor).to eq(DummyProp::BGCOLOR_MAP[:primary])
      expect(dummy.dummy).to eq('dummy')
    end
  end
  context 'ClassMethods' do
    it 'state?' do
      expect(DummyProp.state?(:title)).to be true
    end

    it 'states' do
      expect(DummyProp.status).to include(:title, :description, :color, :bgcolor, :size, :age)
    end
  end

  context 'inherited' do
    it 'initialize' do
      dummy = DummyPropChild1.new(title: 'タイトル')
      expect(dummy.title).to eq 'タイトル'
    end

    it 'props' do
      expect(DummyPropChild1.status).to match_array(%i[title description color bgcolor age size dummy child1])
      expect(DummyPropChild2.status).to match_array(%i[title description color bgcolor age size dummy child2])
    end
  end
end

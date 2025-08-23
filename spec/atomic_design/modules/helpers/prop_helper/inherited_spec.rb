# frozen_string_literal: true

require 'spec_helper'

describe AtomicDesign::Modules::Helpers::PropHelper do # :nodoc:
  it 'initialize' do
    dummy = DummyPropChild1.new(title: 'タイトル')
    expect(dummy.title).to eq 'タイトル'
  end

  it 'props' do
    expect(DummyPropChild1.props).to match_array(%i[title description color bgcolor age size dummy child1])
    expect(DummyPropChild2.props).to match_array(%i[title description color bgcolor age size dummy child2])
  end
end

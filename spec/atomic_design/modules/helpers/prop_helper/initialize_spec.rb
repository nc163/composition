# frozen_string_literal: true

require 'spec_helper'

describe AtomicDesign::Modules::Helpers::PropHelper do # :nodoc:
  it 'initialize' do
    dummy = DummyProp.new(title: 'タイトル')
    expect(dummy.title).to eq 'タイトル'
  end
end

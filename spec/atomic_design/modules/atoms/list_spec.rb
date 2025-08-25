# frozen_string_literal: true

require 'spec_helper'

describe AtomicDesign::Modules::Atoms::List, type: :component do
  it 'props' do
    expect(described_class.props).to match([:order?])
  end

  it 'nesting' do
    expect(described_class.nesting.item).to be_an_instance_of(AtomicDesign::Modules::Atoms::List::Item)
  end
end

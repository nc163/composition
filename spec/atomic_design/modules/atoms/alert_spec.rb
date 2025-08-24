# frozen_string_literal: true

require 'spec_helper'

describe AtomicDesign::Modules::Atoms::Alert, type: :component do
  it 'initialize' do
    expect(described_class.new).to be_an_instance_of(AtomicDesign::Modules::Atoms::Alert)
  end

  # it 'props' do
  #   expect(described_class.props).to be_an_instance_of(AtomicDesign::Modules::Atoms::Alert)
  # end

  it 'props' do
    alert = described_class.new
    puts alert.level
  end
end

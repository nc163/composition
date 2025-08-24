# frozen_string_literal: true

require 'spec_helper'

describe AtomicDesign::Modules::Atoms::Alert, type: :component do
  it 'props' do
    expect(described_class.props).to match([:level])
  end

  it 'props' do
    alert = described_class.new
    puts alert.level
  end
end

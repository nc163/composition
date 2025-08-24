# frozen_string_literal: true

require 'spec_helper'

describe AtomicDesign::Modules::Atoms::Button, type: :component do
  it 'props' do
    expect(described_class.props).to match([:color])
  end
end

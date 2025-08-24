# frozen_string_literal: true

require 'spec_helper'

describe AtomicDesign::Modules::Atoms::Avatar, type: :component do
  it 'initialize' do
    expect(described_class.new(url: 'https://example.com/avatar.png', alt: 'avatar')).to match([:level])
  end
end

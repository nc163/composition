# frozen_string_literal: true

require 'spec_helper'

describe AtomicDesign::Modules::Atoms::List, type: :component do
  let(:view) do
    ActionView::Base.new(ActionView::LookupContext.new([]), {}, nil)
  end

  it 'props' do
    expect(described_class.props).to match([:order?])
  end
end

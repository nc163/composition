# frozen_string_literal: true

require 'rails_helper'

describe AtomicDesign::Components::Atoms::Button, type: :component do
  let(:view) do
    ActionView::Base.new(ActionView::LookupContext.new([]), {}, nil)
  end

  it 'render with default' do
    expect(view.render(described_class.new('ボタン'))).to eq '<span class="btn">ボタン</span>'
  end

  it 'render with color property' do
    expect(view.render(described_class.new(nil, color: :primary))).to include('class="btn text-bg-primary"')
  end
end

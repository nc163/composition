# frozen_string_literal: true

require 'spec_helper'

describe AtomicDesign::Modules::Atoms::Alert, type: :component do
  let(:view) do
    ActionView::Base.new(ActionView::LookupContext.new([]), {}, nil)
  end

  it 'props' do
    expect(described_class.props).to match([:level])
  end

  it 'props' do
    alert = described_class.new
    puts alert.level
  end

  # it 'render' do
  #   options = { class: 'hoge', level: :secondary }
  #
  #   button = described_class.new('カスタムコンテンツ', **options)
  #   rendered = view.render(button)
  #   expect(rendered).to match(/btn #{described_class::COLOR_MAP[options[:color]]}/)
  #   # expect(rendered).to eq "<span class=\"btn #{described_class::COLOR_MAP[options[:color]]}\">カスタムコンテンツ</span>"
  # end
end

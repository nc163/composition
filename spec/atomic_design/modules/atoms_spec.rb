# frozen_string_literal: true

require 'spec_helper'

describe AtomicDesign::Modules::Atoms do
  it 'autoloads' do
    expect(defined?(AtomicDesign::Modules::Atoms::Alert)).to eq('constant')
    expect(defined?(AtomicDesign::Modules::Atoms::Icons)).to eq('constant')
    expect(defined?(AtomicDesign::Modules::Atoms::List)).to eq('constant')
  end
end
# it 'render' do
#   options = { color: :secondary }
#
#   button = described_class.new('カスタムコンテンツ', options)
#   # rendered = view.render(button)
#   # expect(rendered).to eq "<span class=\"btn #{described_class::COLOR_MAP[options[:color]]}\">カスタムコンテンツ</span>"
# end

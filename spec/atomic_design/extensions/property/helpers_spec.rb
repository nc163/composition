# frozen_string_literal: true

require 'spec_helper'

describe AtomicDesign::Extensions::Property::Helpers do # :nodoc:
  colors = {
    primary: { class: 'bg-primary' },
    secondary: { class: 'bg-secondary' },
    success: { class: 'btn-outline-success' },
    danger: { class: 'bg-danger' },
    warning: { class: 'bg-warning' },
    info: { class: 'bg-info' }
  }.freeze

  let(:dummy_class) {
    Class.new do
      include AtomicDesign::Extensions::Property::Helpers

      basic id: 'dummy1'
      state :color,   map: colors,                      required: true,   to: :html
      state :title,                 default: true

      def initialize(*args, **kwargs, &block); end
    end
  }

  let(:sub_dummy_class) {
    Class.new(dummy_class) do
      basic id: 'dummy-sub'
      state :size, default: true
    end
  }

  it 'is correct property' do
    dummy = dummy_class.new(class: 'dummy', color: :primary, title: 'Test Title')
    expect(dummy.html_options).to eq({ id: 'dummy1', class: 'bg-primary dummy' })
    sub = sub_dummy_class.new(color: :secondary, title: 'Test Title')
    expect(sub.html_options).to eq({ id: 'dummy-sub', class: 'bg-secondary' })
  end

  it 'initialize' do
    expect { dummy_class.new }.to raise_error(ArgumentError)
    expect { dummy_class.new(title: 'Test Title') }.to raise_error(ArgumentError)

    expect { dummy_class.new(title: 'Test Title', color: :primary) }.not_to raise_error
  end

  context 'Class Method' do
    it 'プロパティキーが取得できる' do
    expect(dummy_class.properties).to match_array([ :basic, :title, :color ])
    expect(sub_dummy_class.properties).to match_array([ :basic, :title, :color, :size ])
    end

    it 'map指定しているキーを複数形でアクセス' do
      expect(dummy_class.colors).to match_array([ :primary, :secondary, :success, :danger, :warning, :info ])
    end
  end

  context 'Instance Method' do
    it 'is can method' do
      dummy = dummy_class.new(id: 'dummy-1', color: :primary, title: 'Test Title')
      expect(dummy.title).to eq('Test Title')
    end
  end
end

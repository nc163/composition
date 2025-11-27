# frozen_string_literal: true

require 'spec_helper'

describe Composition::Propartiable do # :nodoc:
  let(:dummy_class) {
    Class.new do
      include Composition::Propartiable

      colors = {
        primary: { class: 'bg-primary' },
        secondary: { class: 'bg-secondary' },
        success: { class: 'btn-outline-success' },
        danger: { class: 'bg-danger' },
        warning: { class: 'bg-warning' },
        info: { class: 'bg-info' }
      }.freeze

      alert = {
        primary: { class: 'alert-primary' },
        secondary: { class: 'alert-secondary' },
        success: { class: 'alert-success' },
        danger: { class: 'alert-danger' },
        warning: { class: 'alert-warning' },
        info: { class: 'alert-info' }
      }.freeze

      state :color, colors,                 default: :primary, to: :html_options
      state :alert, alert,                  default: :primary, to: :html_options
      state :title,         required: true, to: nil

      def initialize(*args, **kwargs, &block)
      end

      def self.name
        "DummyClass"
      end
    end
  }

  it 'include' do
    expect(dummy_class.ancestors).to include(Composition::Propartiable)
    expect { dummy_class.new(title: 'hoge') }.not_to raise_error
  end

  it 'property' do
    expect(dummy_class.property).to eq([ :color, :alert, :title ])
  end

  it 'property_method' do
    ins = dummy_class.new(title: 'hoge', color: :info)
    expect(ins.property(:color)).to eq({ class: 'bg-info' })
    expect(ins.property(:alert)).to eq({ class: 'alert-primary' })
    expect(ins.property(:title)).to eq('hoge')
  end

  it 'property_access_method' do
    ins = dummy_class.new(title: 'hoge', alert: :secondary)
    expect(ins.html_options).to eq([
      { class: 'bg-primary' },
      { class: 'alert-secondary' }
    ])
  end
end

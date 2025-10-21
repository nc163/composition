# frozen_string_literal: true

require 'spec_helper'

describe FunctionalView::Propartiable do # :nodoc:
  let(:dummy_class) {
    Class.new do
      include FunctionalView::Propartiable

      colors = {
        primary: { class: 'bg-primary' },
        secondary: { class: 'bg-secondary' },
        success: { class: 'btn-outline-success' },
        danger: { class: 'bg-danger' },
        warning: { class: 'bg-warning' },
        info: { class: 'bg-info' }
      }.freeze

      state :color, colors,                 default: :primary, to: :html_options
      state :title,         required: true

      def initialize(*args, **kwargs, &block)
      end

      def self.name
        "DummyClass"
      end
    end
  }

  it 'include' do
    expect(dummy_class.ancestors).to include(FunctionalView::Propartiable)
    expect { dummy_class.new(title: 'hoge') }.not_to raise_error
  end

  it 'property' do
    expect(dummy_class.property).to eq([ :color, :title ])
  end
end

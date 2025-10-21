# frozen_string_literal: true

require 'spec_helper'

describe FunctionalView::Component do # :nodoc:
  let(:dummy_class) {
    Class.new(described_class) do
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

      def self.name
        "DummyClass"
      end
    end
  }

  let(:sub_dummy_class) {
    Class.new(dummy_class) do
      def self.name
        "SubDummyClass"
      end
    end
  }

  it 'initialize' do
    expect { dummy_class.new }.to raise_error ArgumentError
    expect { dummy_class.new(color: :secondary) }.to raise_error ArgumentError
    expect { dummy_class.new(title: 'Hello') }.not_to raise_error
    expect { dummy_class.new(title: 'Hello', color: :secondary) }.not_to raise_error

    expect { sub_dummy_class.new }.to raise_error ArgumentError
    expect { sub_dummy_class.new(color: :secondary) }.to raise_error ArgumentError
    expect { sub_dummy_class.new(title: 'Hello') }.not_to raise_error
    expect { sub_dummy_class.new(title: 'Hello', color: :secondary) }.not_to raise_error
  end
end

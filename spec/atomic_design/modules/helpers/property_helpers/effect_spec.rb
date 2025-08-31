# frozen_string_literal: true

require 'spec_helper'

describe AtomicDesign::Modules::Helpers::PropertyHelpers::Effect do # :nodoc:
  SIZES = {
    sm: { style: 'width: 25px; height: 25px;' },
    md: { style: 'width: 60px; height: 60px;' },
    lg: { style: 'width: 90px; height: 90px;' }
  }.freeze

  COLORS = {
    primary: { class: 'bg-primary' },
    secondary: { class: 'bg-secondary' },
    success: { class: 'btn-outline-success' },
    danger: { class: 'bg-danger' },
    warning: { class: 'bg-warning' },
    info: { class: 'bg-info' }
  }.freeze

  ALERTS = {
    info: { class: 'alert-info' },
    success: { class: 'alert-success' },
    warning: { class: 'alert-warning' },
    danger: { class: 'alert-danger' }
  }.freeze

  it 'initialize' do
    expect { described_class.new }.not_to raise_error
    expect { described_class.new(required: true) }.not_to raise_error
    expect { described_class.new(to: ALERTS, required: true) }.not_to raise_error
  end

  it 'initialize' do
    effect = described_class.new(to: ALERTS, required: true)
    effect.set(:info)
    expect(effect.value).to eq(ALERTS[:info])
  end
end

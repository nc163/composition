# frozen_string_literal: true

require 'spec_helper'

describe AtomicDesign::Extensions::Property::Functions::Effect do # :nodoc:
  it 'initialize' do
    expect { described_class.new }.not_to raise_error
    expect { described_class.new(required: true) }.not_to raise_error

    proc = Proc.new { |v| "#{((Time.now - v) / 3600).floor}時間前" }
    expect { described_class.new(proc: proc, required: true) }.not_to raise_error
  end

  it 'resolve' do
    proc = Proc.new { |v| "#{((Time.now - v) / 3600).floor}時間前" }
    effect = described_class.new(proc: proc, default: :info)
    expect { effect.call(Time.now) }.not_to raise_error
  end
end

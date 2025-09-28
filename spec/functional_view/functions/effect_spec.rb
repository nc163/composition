# frozen_string_literal: true

require 'spec_helper'

describe Property::Functions::Effect do # :nodoc:
  it 'initialize' do
    expect { described_class.new(name: :dummy) }.not_to raise_error
    expect { described_class.new(name: :dummy, required: true) }.not_to raise_error

    proc = Proc.new { |v| "#{((Time.now - v) / 3600).floor}時間前" }
    expect { described_class.new(proc, name: :dummy, required: true) }.not_to raise_error
  end

  it 'resolve' do
    proc = Proc.new { |v| "#{((Time.now - v) / 3600).floor}時間前" }
    effect = described_class.new(proc, name: :dummy, required: true)
    expect(effect.name).to eq(:dummy)
    # expect(effect.proc).to eq(proc)
    expect(effect.required?).to eq true
  end
end

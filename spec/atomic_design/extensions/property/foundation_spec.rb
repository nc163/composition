# frozen_string_literal: true

require 'spec_helper'

describe AtomicDesign::Extensions::Property::Register do # :nodoc:
  class Dummy < AtomicDesign::Extensions::Property::Function; end


  it 'initialize' do
    expect { described_class.new }.not_to raise_error
  end

  it 'def' do
    effect = described_class.new
    expect { effect.add('<name> required Hash', Dummy.new) }.to raise_error(ArgumentError, "Invalid name")
    expect { effect.add(:name, Dummy.new) }.not_to raise_error
    expect { effect.add(:name, Dummy.new) }.to raise_error(ArgumentError, /Invalid name/)

    expect(effect.find(:name)).to be_a(Dummy)
  end

  it 'clone' do
    effect = described_class.new
    effect.add(:name, Dummy.new)
    clone = effect.clone
    expect(clone.find(:name)).to be_a(Dummy)
  end
end

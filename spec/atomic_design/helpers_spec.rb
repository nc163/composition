# frozen_string_literal: true

require 'spec_helper'

class Dummy # :nodoc:
  include AtomicDesign::Helpers
end

describe Dummy do # :nodoc:
  it 'set_property' do
    expect(described_class.new.respond_to?(:set_property)).to eq true
  end

  context 'ClassMethods' do
    it 'layout' do
      expect(described_class.respond_to?(:layout)).to eq true
    end

    it 'property' do
      expect(described_class.respond_to?(:property)).to eq true
    end
  end
end

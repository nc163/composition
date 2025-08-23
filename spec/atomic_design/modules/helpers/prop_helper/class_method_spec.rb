# frozen_string_literal: true

require 'spec_helper'

describe AtomicDesign::Modules::Helpers::PropHelper do # :nodoc:
  context 'ClassMethods' do
    it 'prop?' do
      expect(DummyProp.prop?(:title)).to be true
    end

    it 'props' do
      expect(DummyProp.props).to include(:title, :description, :color, :bgcolor, :size, :age)
    end
  end
end

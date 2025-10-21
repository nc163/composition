# frozen_string_literal: true

require 'spec_helper'

describe FunctionalView::PropertySet do # :nodoc:
  let(:property_class) { FunctionalView::Property }

  it 'initialize' do
    expect { described_class.new }.not_to raise_error
  end

  it 'append' do
    property = described_class.new
    function = property_class.new(type: :helper, name: :test, argv: [], required: false, default: nil, to: :test_method)
    expect { property.append(function) }.not_to raise_error
    expect { property.append(1) }.to raise_error ArgumentError
    expect(property.count).to eq 1
  end

  it 'any?' do
    property = described_class.new
    expect(property.any?).to be false

    property.append(property_class.new(type: :helper, name: :test, argv: [], required: false, default: nil, to: :test_method))
    expect(property.any?).to be true
  end

  it 'none?' do
    property = described_class.new
    expect(property.none?).to be true

    property.append(property_class.new(type: :helper, name: :test, argv: [], required: false, default: nil, to: :test_method))
    expect(property.none?).to be false
  end

  it 'pluck' do
    property = described_class.new
    property.append property_class.new(type: :helper, name: :test1, argv: [], required: false, default: nil, to: :test_method)
    property.append property_class.new(type: :action, name: :test2, argv: [], required: false, default: nil, to: :test_method)
    plucked_property = property.pluck(:name)
    expect(plucked_property).to eq([ :test1, :test2 ])
  end

  # it 'select' do
  #   property = described_class.new
  #   property.append property_class.new(type: :helper, name: :test1, argv: [], required: false, default: nil, to: :test_method)
  #   property.append property_class.new(type: :action, name: :test2, argv: [], required: false, default: nil, to: :test_method)
  #
  #   selected_property = property.select { |func| func.to == :test_method }
  #   expect(selected_property.count).to eq 2
  #
  #   selected_property = property.select { |func| func.type == :helper }
  #   expect(selected_property.count).to eq 1
  # end
end

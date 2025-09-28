# frozen_string_literal: true

require 'spec_helper'

describe FunctionalView::Property::Functions::Action do # :nodoc:
  it 'initialize' do
    options = {}
    expect { described_class.new(**options) }.to raise_error(ArgumentError, /missing options:/)
    options = { name: :dummy }
    expect { described_class.new(**options) }.to raise_error(ArgumentError, /missing options:/)
    options = { name: :dummy, type: :action }
    expect { described_class.new(**options) }.to raise_error(ArgumentError, /missing options:/)
    options = { name: :dummy, type: :action, to: :props }
    expect { described_class.new(**options) }.not_to raise_error
  end
end

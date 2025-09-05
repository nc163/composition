# frozen_string_literal: true

require 'spec_helper'

describe AtomicDesign::Modules::Helpers do # :nodoc:
  let(:dummy_class) {
    Class.new do
      include AtomicDesign::Modules::Helpers
    end
  }

  it 'initialize' do
    expect { dummy_class.new }.not_to raise_error
  end
end

# frozen_string_literal: true

require 'spec_helper'

describe AtomicDesign::Modules::Helpers::PropHelper do # :nodoc:
  it 'includes the helpers' do
    expect do
      Class.new do
        include AtomicDesign::Modules::Helpers::PropHelper
      end
    end.not_to raise_error
  end

end

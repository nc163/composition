# frozen_string_literal: true

require 'spec_helper'

describe AtomicDesign::Modules::Helpers do # :nodoc:
  it 'includes the helpers' do
    expect do
      Class.new do
        include AtomicDesign::Modules::Helpers
        def self.name
          'Dummy'
        end
      end
    end.not_to raise_error
  end

  it 'successfully includes AtomicDesign::Modules::Helpers::PropHelper' do
    dummy_class = Class.new do
      include AtomicDesign::Modules::Helpers
      def self.name
        'Dummy'
      end
    end
    expect(dummy_class.included_modules).to include(AtomicDesign::Modules::Helpers::PropHelper)
  end
end

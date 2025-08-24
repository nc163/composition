# frozen_string_literal: true

require 'spec_helper'

describe AtomicDesign::Modules::Atoms::Avatar, type: :component do
  it 'initialize' do
    expect(AtomicDesign::Modules::Atoms::Avatar.new).to be_an_instance_of(AtomicDesign::Modules::Atoms::Avatar)
  end
end

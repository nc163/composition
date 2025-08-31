# frozen_string_literal: true

require 'spec_helper'

describe AtomicDesign::Modules::Helpers::PropertyHelpers::EffectHelper do # :nodoc:
  SIZES = {
    sm: { style: 'width: 25px; height: 25px;' },
    md: { style: 'width: 60px; height: 60px;' },
    lg: { style: 'width: 90px; height: 90px;' }
  }.freeze

  class Dummy
    include AtomicDesign::Modules::Helpers::PropertyHelpers

    effect :size, to: SIZES

    def initialize(*args, **kwargs, &block); end
  end

  class SubDummy < Dummy
  end

  it 'includes' do
    expect do
      Class.new do
        include AtomicDesign::Modules::Helpers::PropertyHelpers

        effect :size, to: SIZES
      end
    end.not_to raise_error
  end
end

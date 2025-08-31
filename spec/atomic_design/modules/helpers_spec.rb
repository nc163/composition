# frozen_string_literal: true

require 'spec_helper'

describe AtomicDesign::Modules::Helpers do # :nodoc:
  class Dummy
    include AtomicDesign::Modules::Helpers
  end

  it '' do
    expect { Dummy.new.send(:html_options) }.not_to raise_error
  end
end

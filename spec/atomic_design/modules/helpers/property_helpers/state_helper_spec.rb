# frozen_string_literal: true

require 'spec_helper'

describe AtomicDesign::Modules::Helpers::PropertyHelpers::StateHelper do # :nodoc:
  class Dummy
    include AtomicDesign::Modules::Helpers::PropertyHelpers

    state :title

    def initialize(*args, **kwargs, &block); end
  end

  class SubDummy < Dummy
  end
end

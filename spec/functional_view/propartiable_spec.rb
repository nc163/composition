# frozen_string_literal: true

require 'spec_helper'

describe FunctionalView::Propartiable do # :nodoc:
  it 'include' do
    klass = Class.new do
      include FunctionalView::Propartiable

      def initialize(*args, **kwargs, &block); end
    end
    expect(klass.ancestors).to include(FunctionalView::Propartiable)
    # expect(klass.instance_methods).to include(:function_resolver)
    # expect(klass.instance_methods).to include(:property)
    expect { klass.new }.not_to raise_error
  end
end

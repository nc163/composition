# frozen_string_literal: true

require 'spec_helper'

describe FunctionalView, type: :component do # :nodoc:
  it 'initialize' do
    expect { DummyCard.new }.not_to raise_error
  end
  it 'render' do
    render_inline(DummyCard.new(border: :primary))
    expect(rendered_content).to include('<aside class="card"')
  end
end

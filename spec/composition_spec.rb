# frozen_string_literal: true

require 'spec_helper'

describe Composition, type: :component do # :nodoc:
  it 'initialize' do
    expect { DummyCard.new }.not_to raise_error
  end
  it 'render' do
    render_inline(DummyCard.new(id: 'dummy1', class: 'active', bg: :primary))
    expect(rendered_content).to include('class="card bg-primary active"')
    expect(rendered_content).to include('id="dummy1"')
    expect(rendered_content).to include('<aside')
  end

  it 'render attribute' do
    render_inline(DummyCard.new(id: 'dummy1', class: 'active', bg: :primary))
    expect(rendered_content).to include('<aside class="card bg-primary active" id="dummy1"')
  end
end

# frozen_string_literal: true

require 'spec_helper'

describe FunctionalView, type: :component do # :nodoc:
  it 'initialize' do
    expect { DummyCard.new }.not_to raise_error
  end
  it 'render' do
    render_inline(DummyCard.new(id: 'dummy1', class: 'active', bg: :primary))
    # HTML属性の順序は実装依存なので、含まれることを確認
    expect(rendered_content).to include('class="card bg-primary active"')
    expect(rendered_content).to include('id="dummy1"')
    expect(rendered_content).to include('<aside')
  end
end

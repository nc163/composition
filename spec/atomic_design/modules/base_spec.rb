# frozen_string_literal: true

require 'spec_helper'

describe AtomicDesign::Modules::Base, type: :component do # :nodoc:
  it '初期化' do
    context = 'コンテキスト'
    options = { id: 'test', class: 'test-class' }

    component = described_class.new
    expect(component.send(:options)).to eq({})

    component = described_class.new(nil, options)
    expect(component.send(:options)).to eq({ id: 'test', class: 'test-class' })

    component = described_class.new(context, options)
    expect(component.context).to eq(context)
    expect(component.send(:options)).to eq({ id: 'test', class: 'test-class' })
  end
end

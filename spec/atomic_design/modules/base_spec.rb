# frozen_string_literal: true

require 'spec_helper'

describe AtomicDesign::Modules::Base, type: :component do # :nodoc:
  it '初期化' do
    context = 'コンテキスト'
    options = { id: 'test', class: 'test-class' }

    expect(described_class.new.send(:contexts)).to eq([])
    expect(described_class.new.send(:options)).to eq({})

    expect(described_class.new(nil, **options).send(:contexts)).to eq([nil])
    expect(described_class.new(nil, **options).send(:options)).to eq({ id: 'test', class: 'test-class' })

    expect(described_class.new(context, **options).send(:contexts)).to eq([context])
    expect(described_class.new(context, **options).send(:options)).to eq({ id: 'test', class: 'test-class' })
  end
end

# frozen_string_literal: true

require 'spec_helper'

describe AtomicDesign::Modules::Base, type: :component do # :nodoc:
  it '初期化' do
    context = 'コンテキスト'
    options = { id: 'test', class: 'test-class' }

    expect(described_class.new.send(:context)).to eq(nil)
    expect(described_class.new.send(:options)).to eq({})

    expect(described_class.new(nil, **options).send(:context)).to eq(nil)
    expect(described_class.new(nil, **options).send(:options)).to eq({ id: 'test', class: 'test-class' })

    expect(described_class.new(context, **options).send(:context)).to eq(context)
    expect(described_class.new(context, **options).send(:options)).to eq({ id: 'test', class: 'test-class' })
  end

  context 'dummy' do
    it 'initialize' do
      context = 'コンテキスト'
      options = {
        id: 'dummy-1',
        class: 'dummy',
        order?: true,
        title: 'タイトル',
        src: '/images/60x60.png',
        color: :danger,
        age: 20
      }
      expect { Dummy.new context, **options }.not_to raise_error
      dummy = Dummy.new context, **options

      expect(dummy.send(:context)).to eq(context)
      expect(dummy.send(:order?)).to eq(options[:order?])
      expect(dummy.send(:color)).to eq(Dummy::COLORS[options[:color]])
      expect(dummy.send(:options)).to eq(
        id: 'dummy-1',
        class: "dummy list-group list-group-flush btn-sm #{Dummy::COLORS[options[:color]][:class]}",
        src: '/images/60x60.png' #         ^^^^^^-- 初期値
      )
    end
  end
end

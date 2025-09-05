# frozen_string_literal: true

require 'spec_helper'

describe AtomicDesign::Modules::Base do # :nodoc:
  colors = {
    primary: { class: 'bg-primary' },
    secondary: { class: 'bg-secondary' },
    success: { class: 'btn-outline-success' },
    danger: { class: 'bg-danger' },
    warning: { class: 'bg-warning' },
    info: { class: 'bg-info' }
  }

  sizes = {
    big: { class: 'btn-lg' },
    small: { class: 'btn-sm' }
  }

  let(:dummy_class) {
    Class.new(described_class) do
      basic class: 'list-group list-group-flush'
      state :size,    map: sizes,    default: :small,                     to: :html
      state :color,   map: colors,                      required: true,   to: :html
      state :src,                                       required: true,   to: :html

      state :title,                                     required: true
    end
  }

  it 'initialize' do
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
        # order?: true,
        title: 'タイトル',
        src: '/images/60x60.png',
        color: :danger,
        age: 20
      }
      expect { dummy_class.new context, **options }.not_to raise_error
      dummy = dummy_class.new context, **options

      expect(dummy.send(:color)).to eq(colors[options[:color]])
      # expect(dummy.send(:options)).to eq(
      #   id: 'dummy-1',
      #   class: "dummy list-group list-group-flush btn-sm #{colors[options[:color]][:class]}",
      #   src: '/images/60x60.png' #         ^^^^^^-- 初期値
      # )
    end
  end
end

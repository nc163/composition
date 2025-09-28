# frozen_string_literal: true

require 'spec_helper'

describe Property do # :nodoc:
  colors = {
    primary: { class: 'bg-primary' },
    secondary: { class: 'bg-secondary' },
    success: { class: 'btn-outline-success' },
    danger: { class: 'bg-danger' },
    warning: { class: 'bg-warning' },
    info: { class: 'bg-info' }
  }.freeze

  alerts = {
    primary: { class: 'alert-primary' },
    secondary: { class: 'alert-secondary' },
    success: { class: 'alert-success' },
    danger: { class: 'alert-danger' },
    warning: { class: 'alert-warning' },
    info: { class: 'alert-info' }
  }

  let(:dummy_class) {
    Class.new do
      include Property

      basic id: 'dummy1'
      state :color, colors,  default: :primary, to: :html

      state :title,               default: true
      effect :time, -> (time) { "#{((Time.now - time) / 3600).floor}時間前" }

      def initialize(*args, **kwargs, &block); end
    end
  }

  let(:sub_dummy_class) {
    Class.new(dummy_class)
  }

  it 'initialize' do
    expect(dummy_class.property).to eq([:basic, :color, :title, :time])
    expect { dummy_class.new(color: :secondary) }.not_to raise_error
    expect { sub_dummy_class.new(color: :secondary) }.not_to raise_error
  end

  context 'api' do 
    it 'html_options' do 
      title = 'Hello'
      color = :danger

      dummy = dummy_class.new(class: 'hogehoge', title: title, color: color)
      expect(dummy.html_options).to eq({:id => 'dummy1', :class=>"bg-danger hogehoge"})
    end

    it 'prop' do 
      title = 'Hello'
      color = :danger

      dummy = dummy_class.new(title: title, color: color)
      expect(dummy.prop(:title)).to eq('Hello')
      expect(dummy.prop(:color)).to eq(colors[color])
    end

    it 'dynamic method calling (method_missing)' do
      title = 'Hello'
      color = :danger

      dummy = dummy_class.new(title: title, color: color)
      expect(dummy.title).to eq('Hello')
      expect(dummy.color).to eq(colors[color])
    end
  end
end

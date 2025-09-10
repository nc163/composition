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

  let(:dummy_class) {
    Class.new do
      include Property

      basic id: 'dummy1'
      state :title,               default: true
      state :color, map: colors,  default: :primary, to: :html
      # effect :time, to: -> (time) { "#{((Time.now - time) / 3600).floor}時間前" }
      context :dummy

      def initialize(*args, **kwargs, &block); end
    end
  }

  let(:sub_dummy_class) {
    Class.new(dummy_class)
  }

  it 'initialize' do
    dummy_class.properties
    expect { dummy_class.new(color: :secondary) }.not_to raise_error
    expect { sub_dummy_class.new(color: :secondary) }.not_to raise_error
  end
end

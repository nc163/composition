# frozen_string_literal: true

require 'spec_helper'
require_relative '../fixtures/components/dummy_list'

describe DummyList do
  it 'populates renders_many slot from context property' do
    data = [
      { text: "Item 1" },
      { text: "Item 2" }
    ]

    list = DummyList.new(list_data: data)

    # This is expected to fail currently because Contextable calls with_items
    # instead of iterating and calling with_item

    view_context = ActionController::Base.new.view_context
    output = list.render_in(view_context)

    expect(output).to include("Item 1")
    expect(output).to include("Item 2")
  end
end

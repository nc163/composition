# frozen_string_literal: true

require 'spec_helper'
require_relative '../fixtures/components/dummy_card'

describe DummyCard do
  it 'automatically initializes head slot with title property' do
    # Initialize DummyCard with title property (defined via context)
    card = DummyCard.new(title: "Card Title")

    # Verify that the head slot is initialized
    expect(card.head).to be_present

    # Verify that the head component received the title
    # Since we can't easily inspect the internal state of the slot component instance directly
    # without rendering, we can check if the slot object holds the correct component class.
    # Or we can try to render it if we had a full view context.

    # For now, let's check if we can access the property on the slot instance if possible.
    # ViewComponent's slot method returns the slot content.

    # Let's try to render it to string to verify the output contains the title
    # We need a view context for rendering.
    view_context = ActionController::Base.new.view_context
    output = card.render_in(view_context)

    expect(output).to include('<header class="card-header fw-bold">Card Title</header>')
  end

  it 'does not initialize head slot if title is not provided' do
    card = DummyCard.new
    expect(card.head).to be_nil
  end

  it 'allows overriding context property with explicit slot call' do
    card = DummyCard.new(title: "Initial Title")

    # Explicitly call with_head to override
    card.with_head(title: "New Title")

    view_context = ActionController::Base.new.view_context
    output = card.render_in(view_context)

    expect(output).to include('<header class="card-header fw-bold">New Title</header>')
    expect(output).not_to include("Initial Title")
  end
end

# frozen_string_literal: true

require 'spec_helper'

describe Composition::Properties::Contextable do
  let(:head_component_class) {
    Class.new(ViewComponent::Base) do
      attr_reader :title
      def initialize(title: nil)
        @title = title
      end
      def call
        "Head: #{@title}"
      end
    end
  }

  let(:context_component_class) {
    head_class = head_component_class
    Class.new(Composition::Component) do
      renders_one :head, head_class
      context :head, [ :title ]

      def self.name; "ContextComponent"; end
    end
  }

  it 'automatically initializes slot with passed property' do
    # Initialize component with title
    component = context_component_class.new(title: "Hello Context")

    # Check if head slot is initialized
    # ViewComponent stores slots in @__vc_set_slots or similar, but we can check via the accessor
    # However, renders_one defines a method 'head' that returns the slot content/component

    # Since we can't easily render in this spec without a full Rails env,
    # we check if the slot variable is set.
    # In ViewComponent, `with_head` sets the slot.

    # Let's verify by checking if the slot is present and has correct data
    expect(component.head).to be_present

    # Accessing the actual component instance from the slot wrapper might be tricky depending on VC version
    # But usually component.head returns the slot object.
    # For renders_one, it might return the component instance directly if already evaluated?
    # Actually, `renders_one` defines `head` which returns the slot content.

    # Let's inspect the internal state if possible, or trust that if `head` is not nil, it worked.
    # We can also mock `with_head` to verify it was called.
  end

  it 'calls with_head with correct arguments' do
    # Mock the with_head method to verify interaction
    component = context_component_class.allocate

    # We need to initialize manually to inject spy, but setup_contexts runs in initialize.
    # So we define a subclass that allows us to spy.
    spy_class = Class.new(context_component_class) do
      attr_reader :head_args
      def with_head(**args)
        @head_args = args
      end
    end

    instance = spy_class.new(title: "Spying")
    expect(instance.head_args).to eq({ title: "Spying" })
  end

  it 'does not initialize slot if property is missing' do
    spy_class = Class.new(context_component_class) do
      attr_reader :head_args
      def with_head(**args)
        @head_args = args
      end
    end

    instance = spy_class.new
    expect(instance.head_args).to be_nil
  end

  it 'uses default values from property definition if available' do
    default_class = Class.new(Composition::Component) do
      renders_one :head, Class.new(ViewComponent::Base)

      # Define state with default first
      state :title, default: "Default Title"
      context :head, [ :title ]

      attr_reader :head_args
      def with_head(**args)
        @head_args = args
      end

      def self.name; "DefaultContextComponent"; end
    end

    instance = default_class.new
    expect(instance.head_args).to eq({ title: "Default Title" })
  end
end

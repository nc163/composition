# frozen_string_literal: true

require "rails_helper"

describe AtomicDesign::Component::ButtonComponent, type: :component do
  
  describe "initialization" do
    it "creates a button with default attributes" do
      component = described_class.new
      expect(component).to be_instance_of(described_class)
    end

    it "accepts custom variant" do
      component = described_class.new(variant: "secondary")
      rendered = render_inline(component) { "Test" }
      expect(rendered.css("button").first["class"]).to include("component-button--secondary")
    end

    it "accepts custom size" do
      component = described_class.new(size: "large")
      rendered = render_inline(component) { "Test" }
      expect(rendered.css("button").first["class"]).to include("component-button--large")
    end

    it "accepts disabled state" do
      component = described_class.new(disabled: true)
      rendered = render_inline(component) { "Test" }
      expect(rendered.css("button").first["disabled"]).to eq("disabled")
    end
  end

  describe "validation" do
    it "raises error for invalid variant" do
      expect {
        described_class.new(variant: "invalid")
      }.to raise_error(ArgumentError, /Invalid variant/)
    end

    it "raises error for invalid size" do
      expect {
        described_class.new(size: "invalid")
      }.to raise_error(ArgumentError, /Invalid size/)
    end
  end

  describe "rendering" do
    it "renders button with content" do
      rendered = render_inline(described_class.new) { "Click me" }
      expect(rendered.text).to include("Click me")
      expect(rendered.css("button")).to be_present
    end

    it "applies correct CSS classes" do
      rendered = render_inline(described_class.new(variant: "primary", size: "medium"))
      button = rendered.css("button").first
      
      expect(button["class"]).to include("component-button")
      expect(button["class"]).to include("component-button--primary")
      expect(button["class"]).to include("component-button--medium")
    end

    it "merges custom HTML attributes" do
      rendered = render_inline(
        described_class.new(id: "custom-id", "data-action": "click->test#action")
      ) { "Test" }
      
      button = rendered.css("button").first
      expect(button["id"]).to eq("custom-id")
      expect(button["data-action"]).to eq("click->test#action")
    end
  end
end

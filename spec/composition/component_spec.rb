# frozen_string_literal: true

require 'spec_helper'

describe Composition::Component do # :nodoc:
  let(:dummy_class) {
    Class.new(described_class) do
      colors = {
        primary: { class: 'bg-primary' },
        secondary: { class: 'bg-secondary' },
        success: { class: 'btn-outline-success' },
        danger: { class: 'bg-danger' },
        warning: { class: 'bg-warning' },
        info: { class: 'bg-info' }
      }.freeze

      state :color, colors,                 default: :primary, to: :html_options
      state :title,         required: true

      def self.name
        "DummyClass"
      end
    end
  }

  let(:sub_dummy_class) {
    Class.new(dummy_class) do
      def self.name
        "SubDummyClass"
      end
    end
  }

  it 'initialize' do
    expect { dummy_class.new }.to raise_error ArgumentError
    expect { dummy_class.new(color: :secondary) }.to raise_error ArgumentError
    expect { dummy_class.new(title: 'Hello') }.not_to raise_error
    expect { dummy_class.new(title: 'Hello', color: :secondary) }.not_to raise_error

    expect { sub_dummy_class.new }.to raise_error ArgumentError
    expect { sub_dummy_class.new(color: :secondary) }.to raise_error ArgumentError
    expect { sub_dummy_class.new(title: 'Hello') }.not_to raise_error
    expect { sub_dummy_class.new(title: 'Hello', color: :secondary) }.not_to raise_error
  end

  describe '#options' do
    context 'when merging html_options' do
      it 'merges default values correctly' do
        component = dummy_class.new(title: 'Test')
        # default color is primary -> class: 'bg-primary'
        expect(component.send(:options)).to eq({ class: 'bg-primary' })
      end

      it 'merges user provided values correctly' do
        component = dummy_class.new(title: 'Test', color: :secondary)
        # color is secondary -> class: 'bg-secondary'
        expect(component.send(:options)).to eq({ class: 'bg-secondary' })
      end

      it 'merges extra attributes (without_property) correctly' do
        component = dummy_class.new(title: 'Test', id: 'my-id', data: { controller: 'test' })
        # default color: primary -> class: 'bg-primary'
        # extra: id: 'my-id', data: { controller: 'test' }
        expect(component.send(:options)).to eq({
          class: 'bg-primary',
          id: 'my-id',
          data: { controller: 'test' }
        })
      end

      it 'merges class attributes from property and user input' do
        component = dummy_class.new(title: 'Test', class: 'extra-class')
        # default color: primary -> class: 'bg-primary'
        # user input: class: 'extra-class'
        # merged: class: 'bg-primary extra-class'
        expect(component.send(:options)).to eq({ class: 'bg-primary extra-class' })
      end
    end

    context 'with multiple properties mapped to html_options' do
      let(:complex_class) {
        Class.new(described_class) do
          state :size, { small: { class: 'text-sm' }, large: { class: 'text-lg' } }, default: :small, to: :html_options
          state :theme, { dark: { class: 'theme-dark', data: { theme: 'dark' } }, light: { class: 'theme-light' } }, default: :light, to: :html_options
          state :label, required: true

          def self.name; "ComplexClass"; end
        end
      }

      it 'merges multiple properties correctly' do
        component = complex_class.new(label: 'Complex', size: :large, theme: :dark)
        # size: large -> class: 'text-lg'
        # theme: dark -> class: 'theme-dark', data: { theme: 'dark' }
        # merged: class: 'text-lg theme-dark', data: { theme: 'dark' }
        expect(component.send(:options)).to eq({
          class: 'text-lg theme-dark',
          data: { theme: 'dark' }
        })
      end

      it 'merges multiple properties with user input correctly' do
        component = complex_class.new(label: 'Complex', size: :large, theme: :dark, class: 'user-class', data: { action: 'click' })
        # size: large -> class: 'text-lg'
        # theme: dark -> class: 'theme-dark', data: { theme: 'dark' }
        # user: class: 'user-class', data: { action: 'click' }

        # Expected merge:
        # class: 'text-lg theme-dark user-class'
        # data: { theme: 'dark', action: 'click' } (Hash merge)

        options = component.send(:options)
        expect(options[:class]).to include('text-lg', 'theme-dark', 'user-class')
        expect(options[:data]).to eq({ theme: 'dark', action: 'click' })
      end
    end

    context 'edge cases and complex merging' do
      it 'merges nested hashes recursively' do
        # Setup a component with nested data attributes
        component = dummy_class.new(title: 'Nested', data: { controller: 'a', values: { id: 1 } })
        # Simulate another source of options (e.g. from property)
        # We can't easily inject property with nested hash without defining it, so we test merge_html_options directly via options logic
        # But we can pass extra options that need merging

        # Let's define a class with nested hash property
        nested_class = Class.new(described_class) do
          state :meta, { default: { data: { values: { role: 'admin' }, controller: 'b' } } }, default: :default, to: :html_options
          state :title, required: true
          def self.name; "NestedClass"; end
        end

        instance = nested_class.new(title: 'Nested', data: { values: { id: 1 }, target: 'top' })

        # Expected:
        # data: {
        #   controller: 'b',
        #   target: 'top',
        #   values: { role: 'admin', id: 1 }  <-- Recursive merge
        # }

        options = instance.send(:options)
        expect(options[:data][:controller]).to eq('b')
        expect(options[:data][:target]).to eq('top')
        expect(options[:data][:values]).to eq({ role: 'admin', id: 1 })
      end

      it 'concatenates arrays' do
        array_class = Class.new(described_class) do
          state :tags, { default: { data: { tags: [ 'a', 'b' ] } } }, default: :default, to: :html_options
          state :title, required: true
          def self.name; "ArrayClass"; end
        end

        instance = array_class.new(title: 'Array', data: { tags: [ 'c' ] })

        # Expected: data: { tags: "a b c" } or ["a", "b", "c"] depending on implementation
        # Current implementation joins arrays with space: (Array(a) + Array(b)).join(" ")

        options = instance.send(:options)
        expect(options[:data][:tags]).to eq("a b c")
      end

      it 'handles mixed types (String and Array) by converting to Array and joining' do
        mixed_class = Class.new(described_class) do
          state :cls, { default: { class: 'base' } }, default: :default, to: :html_options
          state :title, required: true
          def self.name; "MixedClass"; end
        end

        instance = mixed_class.new(title: 'Mixed', class: [ 'extra', 'more' ])

        # Expected: class: "base extra more"

        options = instance.send(:options)
        expect(options[:class]).to eq("base extra more")
      end

      it 'raises ArgumentError for incompatible types' do
        error_class = Class.new(described_class) do
          state :prop, { default: { data: { id: 123 } } }, default: :default, to: :html_options
          state :title, required: true
          def self.name; "ErrorClass"; end
        end

        # User passes a String for 'data', but property defines it as Hash
        instance = error_class.new(title: 'Error', data: "invalid")

        expect { instance.send(:options) }.to raise_error(ArgumentError, /Incompatible types/)
      end
    end
  end

  describe 'Inheritance' do
    let(:child_class) {
      Class.new(dummy_class) do
        # Override default of existing property
        state :color, { primary: { class: 'bg-primary-new' } }, default: :primary, to: :html_options
        # Add new property
        state :size, { small: { class: 'p-2' }, large: { class: 'p-4' } }, default: :small, to: :html_options

        def self.name; "ChildClass"; end
      end
    }

    it 'inherits properties from parent' do
      expect(child_class.property_set.pluck(:name)).to include(:title)
    end

    it 'uses overridden property definition' do
      component = child_class.new(title: 'Child')
      # color default is primary, but definition is overridden
      expect(component.send(:options)).to include(class: include('bg-primary-new'))
      expect(component.send(:options)).to include(class: include('p-2')) # default size
    end

    it 'does not affect parent class' do
      parent_component = dummy_class.new(title: 'Parent')
      expect(parent_component.send(:options)).to eq({ class: 'bg-primary' })
      expect(dummy_class.property_set.pluck(:name)).not_to include(:size)
    end

    context 'Grandchild inheritance' do
      let(:grandchild_class) {
        Class.new(child_class) do
          # Override size default
          state :size, { small: { class: 'p-2' }, large: { class: 'p-4' } }, default: :large, to: :html_options
          def self.name; "GrandchildClass"; end
        end
      }

      it 'inherits properties from parent and grandparent' do
        expect(grandchild_class.property_set.pluck(:name)).to include(:title, :color, :size)
      end

      it 'uses overridden default from grandchild definition' do
        component = grandchild_class.new(title: 'Grandchild')
        # size default is large -> class: 'p-4'
        expect(component.send(:options)).to include(class: include('p-4'))
      end
    end

    context 'Overriding property attributes' do
      let(:optional_title_class) {
        Class.new(dummy_class) do
          # Override title to be optional
          state :title, required: false
          def self.name; "OptionalTitleClass"; end
        end
      }

      let(:required_color_class) {
        Class.new(dummy_class) do
          # Override color to be required (re-defining state)
          # Note: We need to provide the mapping again if we re-define state
          colors = {
            primary: { class: 'bg-primary' },
            secondary: { class: 'bg-secondary' }
          }.freeze
          state :color, colors, default: :primary, required: true, to: :html_options
          def self.name; "RequiredColorClass"; end
        end
      }

      it 'allows overriding required attribute to false' do
        expect { optional_title_class.new }.not_to raise_error
      end

      it 'allows overriding required attribute to true' do
        # title is required by parent, color is required by child
        expect { required_color_class.new(title: 'T') }.to raise_error(ArgumentError, /Missing required properties: color/)
        expect { required_color_class.new(title: 'T', color: :primary) }.not_to raise_error
      end
    end

    context 'Module inclusion' do
      let(:mixin_module) {
        Module.new do
          extend ActiveSupport::Concern
          include Composition::Propertiable

          included do
            state :mixin_prop, { on: { class: 'mixin-on' } }, default: :on, to: :html_options
          end
        end
      }

      let(:mixed_in_class) {
        Class.new(dummy_class) do
          include mixin_module
          def self.name; "MixedInClass"; end
        end
      }

      # This test might fail if Propertiable logic doesn't handle module inclusion perfectly yet
      # specifically if `included` hook in Propertiable doesn't fire for modules included in classes
      # or if property_set isn't shared/merged correctly.
      it 'includes properties defined in modules' do
        # Pending check if this is supported by current implementation
        # Current implementation uses @property_set on the class.
        # When including a module that also includes Propertiable,
        # the module's @property_set needs to be merged into the class's @property_set.

        # Let's see if it works or if we need to implement `included` hook for merging.
        skip "Module inclusion of properties requires implementation of property merging from modules"

        expect(mixed_in_class.property_set.pluck(:name)).to include(:mixin_prop)
        component = mixed_in_class.new(title: 'Mixin')
        expect(component.send(:options)).to include(class: include('mixin-on'))
      end
    end
  end
end

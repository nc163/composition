# frozen_string_literal: true

require 'spec_helper'

describe AtomicDesign::Helpers::ModuleHelper, type: :helper do # :nodoc:
  let(:view) do
    ActionView::Base.new(ActionView::LookupContext.new([]), {}, nil)
  end

  before do
    view.extend(described_class)
  end

  it 'provides atomic_design proxy on the view' do
    expect(view).to respond_to(:atomic_design)
    expect(view.atomic_design).to respond_to(:atoms, :moles, :orgas, :temps, :pages)

    expect(view.atomic_design.atoms.button).to match(%r{<button.*?/button>}m)
    # expect(view.atomic_design.atoms.icons.fa6).to match(/<i.*?\/i>/m)
  end

  it 'raises an error when referencing a non-existent builder component' do
    expect do
      view.atomic_design.atoms.non_existent_component
    end.to raise_error(/is not defined\./)
  end
end

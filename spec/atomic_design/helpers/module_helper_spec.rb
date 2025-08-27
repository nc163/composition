# frozen_string_literal: true

require 'spec_helper'

describe AtomicDesign::Helpers::ModuleHelpers, type: :helper do # :nodoc:
  let(:view) do
    ActionView::Base.new(ActionView::LookupContext.new([]), {}, nil)
  end

  before do
    view.extend(described_class)
  end

  it 'provides atomic_design proxy' do
    expect(view).to respond_to(:atomic_design)
    expect(view.atomic_design).to respond_to(:atoms, :moles, :orgas, :temps, :pages)

    expect(view.atomic_design.atoms.button).to be_an_instance_of(AtomicDesign::Modules::Atoms::Button)
    expect(view.atomic_design.atoms.icons).to be_an_instance_of(AtomicDesign::Helpers::ModuleHelpers::ModuleBuilder)
    expect(view.atomic_design.atoms.icons.font_awesome_6(nil, icon: :question)).to be_an_instance_of(AtomicDesign::Modules::Atoms::Icons::FontAwesome6)
  end

  it 'raises an error when referencing a non-existent builder component' do
    expect { view.atomic_design.atoms.non_existent_component }.to raise_error(/undefined method/)
  end
end

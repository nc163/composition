# frozen_string_literal: true

require 'rails_helper'
require 'atomic_design/component/base'

describe AtomicDesign::Component::Base, type: :component do
  let(:component_class) { AtomicDesign::Component::Base }

  describe 'initialization' do
    context '引数なしで初期化' do
      it 'contextとoptionsが正しく設定される' do
        component = component_class.new
        expect(component.context).to be_nil
        expect(component.options).to eq({})
      end
    end

    context 'contextのみを渡した場合' do
      it 'contextが正しく設定される' do
        context_value = 'test_context'
        component = component_class.new(context_value)
        expect(component.context).to eq(context_value)
        expect(component.options).to eq({})
      end
    end

    context 'optionsのみを渡した場合' do
      it 'optionsが正しく設定される' do
        options = { id: 'test', class: 'test-class' }
        component = component_class.new(options)
        expect(component.context).to eq(options)
        expect(component.options).to eq({})
      end
    end

    context 'contextとoptionsの両方を渡した場合' do
      it '両方が正しく設定される' do
        context_value = 'test_context'
        options = { id: 'test', class: 'test-class' }
        component = component_class.new(context_value, options)
        expect(component.context).to eq(context_value)
        expect(component.options).to eq(options)
      end
    end

    context 'ブロック付きで初期化した場合' do
      it 'optionsとしてcontextが扱われ、contextがnilになる' do
        options = { id: 'test', class: 'test-class' }
        component = component_class.new(options) {}
        expect(component.context).to be_nil
        expect(component.options).to eq(options)
      end

      it '引数がnilの場合は空のoptionsが設定される' do
        component = component_class.new {}
        expect(component.context).to be_nil
        expect(component.options).to eq({})
      end
    end

    context '無効なキーワードが渡された場合' do
      it ':propertiesキーワードでArgumentErrorが発生する' do
        expect do
          component_class.new(properties: 'invalid')
        end.to raise_error(ArgumentError, 'Invalid arguments')
      end

      it ':attributesキーワードでArgumentErrorが発生する' do
        expect do
          component_class.new(attributes: 'invalid')
        end.to raise_error(ArgumentError, 'Invalid arguments')
      end

      it '複数の無効なキーワードでArgumentErrorが発生する' do
        expect do
          component_class.new(properties: 'invalid', attributes: 'invalid')
        end.to raise_error(ArgumentError, 'Invalid arguments')
      end
    end
  end

  describe 'attr_accessor' do
    let(:component) { component_class.new }

    describe 'context' do
      it '読み書きができる' do
        test_context = 'test_context'
        component.context = test_context
        expect(component.context).to eq(test_context)
      end
    end

    describe 'options' do
      it '読み書きができる' do
        test_options = { id: 'test' }
        component.options = test_options
        expect(component.options).to eq(test_options)
      end
    end

    describe 'form' do
      it '読み書きができる' do
        test_form = double('form')
        component.form = test_form
        expect(component.form).to eq(test_form)
      end
    end
  end

  describe '#context?' do
    context 'contextが設定されている場合' do
      it 'trueを返す' do
        component = component_class.new('test_context')
        expect(component.context?).to be true
      end
    end

    context 'contextがnilの場合' do
      it 'falseを返す' do
        component = component_class.new
        expect(component.context?).to be false
      end
    end

    context 'contextが空文字列の場合' do
      it 'trueを返す' do
        component = component_class.new('')
        expect(component.context?).to be true
      end
    end

    context 'contextがfalseの場合' do
      it 'trueを返す' do
        component = component_class.new(false)
        expect(component.context?).to be true
      end
    end
  end

  describe '#attributes' do
    let(:component) { component_class.new(nil, { id: 'test', class: 'test-class' }) }

    before do
      # to_html_attributesとpartition_byメソッドをモック
      allow(component).to receive(:to_html_attributes).and_return([{ class: 'base-class' }])
      allow(component).to receive(:partition_by).and_return({ id: 'test', class: 'test-class' })
    end

    it 'HTML属性が正しく返される' do
      result = component.attributes
      expect(result).to be_a(Hash)
      expect(result[:id]).to eq('test')
      expect(result[:class]).to eq('base-class test-class')
    end
  end

  describe '#form_with' do
    let(:component) { component_class.new }
    let(:helpers_mock) { double('helpers') }

    before do
      allow(component).to receive(:helpers).and_return(helpers_mock)
    end

    it 'デフォルト設定が適用される' do
      expect(helpers_mock).to receive(:form_with).with(
        class: 'form',
        local: true,
        builder: AtomicDesign::Helpers::FormBuilder
      )

      component.form_with
    end

    it 'カスタムオプションが適用される' do
      custom_options = { class: 'custom-form', method: :post }
      expect(helpers_mock).to receive(:form_with).with(
        class: 'custom-form',
        local: true,
        builder: AtomicDesign::Helpers::FormBuilder,
        method: :post
      )

      component.form_with(custom_options)
    end

    it 'ブロックが正しく渡される' do
      block = proc { 'test block' }
      expect(helpers_mock).to receive(:form_with).with(
        class: 'form',
        local: true,
        builder: AtomicDesign::Helpers::FormBuilder
      ).and_yield

      component.form_with(&block)
    end
  end

  describe '#merge_html_attributes' do
    let(:component) { component_class.new }

    context 'classのマージ' do
      it '複数のclass値がスペース区切りでマージされる' do
        result = component.send(:merge_html_attributes, :class, 'old-class', 'new-class')
        expect(result).to eq('old-class new-class')
      end

      it 'nilがある場合は無視される' do
        result = component.send(:merge_html_attributes, :class, nil, 'new-class')
        expect(result).to eq('new-class')
      end
    end

    context 'styleのマージ' do
      it '複数のstyle値がセミコロン区切りでマージされる' do
        result = component.send(:merge_html_attributes, :style, 'color: red', 'background: blue')
        expect(result).to eq('color: red; background: blue')
      end

      it 'nilがある場合は無視される' do
        result = component.send(:merge_html_attributes, :style, 'color: red', nil)
        expect(result).to eq('color: red')
      end
    end

    context 'dataのマージ' do
      it 'data属性がハッシュとしてマージされる' do
        old_data = { toggle: 'modal' }
        new_data = { target: '#modal' }
        result = component.send(:merge_html_attributes, :data, old_data, new_data)
        expect(result).to eq({ toggle: 'modal', target: '#modal' })
      end

      it '同じキーの場合は新しい値で上書きされる' do
        old_data = { toggle: 'modal' }
        new_data = { toggle: 'dropdown' }
        result = component.send(:merge_html_attributes, :data, old_data, new_data)
        expect(result).to eq({ toggle: 'dropdown' })
      end
    end

    context '無効なキー' do
      it 'サポートされていないキーで例外が発生する' do
        expect do
          component.send(:merge_html_attributes, :invalid, 'old', 'new')
        end.to raise_error('Invalid key: invalid')
      end
    end

    context 'キーがSymbolでない場合' do
      it 'ArgumentErrorが発生する' do
        expect do
          component.send(:merge_html_attributes, 'class', 'old', 'new')
        end.to raise_error(ArgumentError, 'Key must be a Symbol')
      end
    end
  end

  describe '#partition_by_attr_accessor_for_send' do
    let(:component) { component_class.new }

    context 'attr_accessor対応属性の処理' do
      it '対応する属性が正しく設定される' do
        params = { context: 'test_context', form: 'test_form', other: 'value' }
        result = component.send(:partition_by_attr_accessor_for_send, params)

        expect(component.context).to eq('test_context')
        expect(component.form).to eq('test_form')
        expect(result).to eq({ other: 'value' })
      end
    end

    context 'contextキーワードの再帰処理' do
      it 'contextキーワードがある場合の再帰処理' do
        params = { context: { nested_context: 'value' }, other: 'value' }
        result = component.send(:partition_by_attr_accessor_for_send, params)

        expect(result).to eq({ other: 'value' })
      end
    end

    context 'その他の属性の返却' do
      it 'attr_accessorに対応しない属性が返される' do
        params = { id: 'test', class: 'test-class', data: { toggle: 'modal' } }
        result = component.send(:partition_by_attr_accessor_for_send, params)

        expect(result).to eq(params)
      end
    end
  end

  describe 'クラスメソッド' do
    describe '.options_for_self' do
      it '正しくオプションが返される' do
        allow(component_class).to receive(:to_options_for_self).and_return([{ id: 'test' }, { class: 'test-class' }])
        result = component_class.options_for_self
        expect(result).to eq({ id: 'test', class: 'test-class' })
      end

      it '空の配列の場合はnilが返される' do
        allow(component_class).to receive(:to_options_for_self).and_return([])
        result = component_class.options_for_self
        expect(result).to be_nil
      end
    end

    describe '.lambda_slots_component_handler' do
      let(:valid_component_class) { Class.new(AtomicDesign::Component::Base) }
      let(:invalid_component_class) { Class.new }

      it 'AtomicDesign::Component::Baseを継承していないクラスでArgumentErrorが発生する' do
        expect do
          component_class.send(:lambda_slots_component_handler, invalid_component_class)
        end.to raise_error(ArgumentError)
      end

      it '正しいProcが返される' do
        result = component_class.send(:lambda_slots_component_handler, valid_component_class)
        expect(result).to be_a(Proc)

        # Procを実行してコンポーネントが作成されることを確認
        instance = result.call('test_context', { id: 'test' })
        expect(instance).to be_instance_of(valid_component_class)
        expect(instance.context).to eq('test_context')
      end

      it 'ブロック付きでProcが実行できる' do
        result = component_class.send(:lambda_slots_component_handler, valid_component_class)
        instance = result.call({ id: 'test' }) {}
        expect(instance).to be_instance_of(valid_component_class)
        expect(instance.context).to be_nil
      end
    end
  end

  describe '継承とモジュール連携' do
    it 'ViewComponent::Baseを継承している' do
      expect(component_class.superclass).to eq(ViewComponent::Base)
    end

    it 'DefaultLayoutモジュールがincludeされている' do
      expect(component_class.included_modules).to include(AtomicDesign::Component::DefaultLayout)
    end

    it 'Propertyモジュールがincludeされている' do
      expect(component_class.included_modules).to include(AtomicDesign::Component::Property)
    end
  end

  describe '定数' do
    it 'INVALID_OPTIONS_KEYWORDSが正しく定義されている' do
      expect(component_class::INVALID_OPTIONS_KEYWORDS).to eq(%i[properties attributes])
    end
  end

  describe 'エラーハンドリング' do
    context 'initializeでの異常系' do
      it 'optionsがnilの場合でもエラーにならない' do
        expect do
          component_class.new('context', nil)
        end.not_to raise_error
      end

      it 'contextがハッシュでoptionsが空の場合' do
        context_hash = { id: 'test' }
        component = component_class.new(context_hash, {})
        expect(component.context).to eq(context_hash)
      end
    end

    context 'attributesメソッドでの異常系' do
      it 'to_html_attributesがnilを返す場合' do
        component = component_class.new
        allow(component).to receive(:to_html_attributes).and_return(nil)
        allow(component).to receive(:partition_by).and_return({})

        # compactが呼ばれるのでnilは除外される
        expect { component.attributes }.not_to raise_error
      end
    end
  end
end

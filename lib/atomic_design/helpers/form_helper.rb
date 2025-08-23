# frozen_string_literal: true

module AtomicDesign
  module Helpers
    # = AtomicDesign Form Helpers
    module FormHelper
      # see: https://api.rubyonrails.org/v8.0/classes/ActionView/Helpers/FormBuilder.html
      class AtomicDesignFormBuilder < ::ActionView::Helpers::FormBuilder
        # フィールドタイプとメソッドのマッピング
        FIELD_MAPPINGS = {
          string: :text_field,
          text: :text_area,
          integer: :text_field,
          float: :text_field,
          decimal: :text_field,
          boolean: :check_box,
          date: :date_field,
          time: :time_field,
          datetime: :datetime_field,
          select: :select
        }.freeze

        def any_field(type, ...)
          field_method = FIELD_MAPPINGS[type]
          raise ArgumentError, "Unknown form field type: #{type}" unless field_method

          method(field_method).call(...)
        end

        # def label(method, **options)
        #   options[:form] = self
        #   @template.render AtomicDesign::Modules::Atoms::Form::Label.new(method, **options)
        # end

        def text_field(method, **options)
          if options.delete(:use_default)
            super(method, **options)
          else
            options[:form] = self
            @template.render AtomicDesign::Modules::Atoms::Form::TextField.new(method, **options)
          end
        end

        def text_area(method, **options)
          if options.delete(:use_default)
            super(method, **options)
          else
            options[:form] = self
            @template.render AtomicDesign::Modules::Atoms::Form::TextArea.new(method, **options)
          end
        end

        def check_box(method, **options)
          if options.delete(:use_default)
            super(method, **options)
          else
            options[:form] = self
            @template.render AtomicDesign::Modules::Atoms::Form::CheckBoxField.new(method, **options)
          end
        end

        def date_field(method, **options)
          if options.delete(:use_default)
            super(method, **options)
          else
            options[:form] = self
            @template.render AtomicDesign::Modules::Atoms::Form::DateField.new(method, **options)
          end
        end

        def time_field(method, **options)
          if options.delete(:use_default)
            super(method, **options)
          else
            options[:form] = self
            @template.render AtomicDesign::Modules::Atoms::Form::TimeField.new(method, **options)
          end
        end

        def datetime_field(method, **options)
          if options.delete(:use_default)
            super(method, **options)
          else
            options[:form] = self
            @template.render AtomicDesign::Modules::Atoms::Form::DatetimeField.new(method, **options)
          end
        end

        # https://api.rubyonrails.org/v8.0/classes/ActionView/Helpers/FormBuilder.html#method-i-select
        def select(method = nil, choices = nil, options = {}, &block)
          if options.delete(:use_default)
            super(method, choices, { include_blank: '選択してください' }, **options)
          else
            options[:form] = self
            @template.render AtomicDesign::Modules::Atoms::Form::Select.new(method, **options)
          end
        end

        #
        def submit(method = nil, **options, &block)
          if options.delete(:use_default)
            super(method, **options)
          else
            options[:form] = self
            @template.render AtomicDesign::Modules::Atoms::Form::Submit.new(method, **options)
          end
        end

        private

        #
        def component(component_name, method = nil, **options, &block)
          component = component_name.to_s.camelize.safe_constantize
          raise "Forget to define #{component_name} ?" if component.nil?
          unless component < AtomicDesign::Base
            raise "#{component}(#{component_name}) must inherit from ApplicationComponent."
          end

          options[:form] = self
          @template.render component.new(method, **options), &block
        end
      end

      # def atomic_design_form_with
      #   options = {}
      #   options[:form] = self
      #   @template.render AtomicDesign::Modules::Atoms::Form.new(**options)
      # end
    end
  end
end

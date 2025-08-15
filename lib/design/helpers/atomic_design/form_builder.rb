# frozen_string_literal: true

#
module Design
  module Helpers
    module AtomicDesign
      # See https://api.rubyonrails.org/v8.0/classes/ActionView/Helpers/FormBuilder.html
      class FormBuilder < ActionView::Helpers::FormBuilder

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

        # def field(type, method, **options)
        #   field_method = FIELD_MAPPINGS[type]
        #   raise ArgumentError, "Unknown form field type: #{type}" unless field_method

        #   self.method(field_method).call(method, **options)
        # end

        def field(type, ...)
          field_method = FIELD_MAPPINGS[type]
          raise ArgumentError, "Unknown form field type: #{type}" unless field_method

          self.method(field_method).call(...)
        end

        def text_field(method, **options)
          if options.delete(:use_default)
            super(method, **options)
          else
            options[:form] = self
            @template.render Design::Component::AtomicDesign::Atoms::Form::TextField.new(method, **options)
          end
        end


        def text_area(method, **options)
          if options.delete(:use_default)
            super(method, **options)
          else
            options[:form] = self
            @template.render Design::Component::AtomicDesign::Atoms::Form::TextArea.new(method, **options)
          end
        end


        def check_box(method, **options)
          if options.delete(:use_default)
            super(method, **options)
          else
            options[:form] = self
            @template.render Design::Component::AtomicDesign::Atoms::Form::CheckBoxField.new(method, **options)
          end
        end


        def date_field(method, **options)
          if options.delete(:use_default)
            super(method, **options)
          else
            options[:form] = self
            @template.render Design::Component::AtomicDesign::Atoms::Form::DateField.new(method, **options)
          end
        end


        def time_field(method, **options)
          if options.delete(:use_default)
            super(method, **options)
          else
            options[:form] = self
            @template.render Design::Component::AtomicDesign::Atoms::Form::TimeField.new(method, **options)
          end
        end


        def datetime_field(method, **options)
          if options.delete(:use_default)
            super(method, **options)
          else
            options[:form] = self
            @template.render Design::Component::AtomicDesign::Atoms::Form::DatetimeField.new(method, **options)
          end
        end

        # https://api.rubyonrails.org/v8.0/classes/ActionView/Helpers/FormBuilder.html#method-i-select
        def select(method = nil, choices = nil, options = {}, &block)
          if options.delete(:use_default)
            super(method, choices, { include_blank: '選択してください' }, **options)
          else
            options[:form] = self
            @template.render Design::Component::AtomicDesign::Atoms::Form::Select.new(method, **options)
          end
        end

        #
        def submit(method = nil, **options, &block)
          if options.delete(:use_default)
            super(method, **options)
          else
            options[:form] = self
            @template.render Design::Component::AtomicDesign::Atoms::Form::Submit.new(method, **options)
          end
        end

        private

        #
        def component(component_name, method = nil, **options, &block)
          component = component_name.to_s.camelize.safe_constantize
          raise "Forget to define #{component_name} ?" if component.nil?
          raise "#{component}(#{component_name}) must inherit from ApplicationComponent." unless component < Design::Component::Base

          options[:form] = self
          @template.render component.new(method, **options), &block
        end

      end
    end
  end
end

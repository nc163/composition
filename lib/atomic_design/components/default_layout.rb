# frozen_string_literal: true

module AtomicDesign
  module Components
    module DefaultLayout
      def self.included(base)
        base.extend ClassMethods
      end

      protected

      # HTML属性を配列で返す
      def to_html_attributes(html_attributes = [])
        html_attributes = super(html_attributes) if defined?(super)

        html_attributes + [self.class.default_layout]
      end

      #
      module ClassMethods
        # 初期値を設定
        def default_layout(**html_attributes_hash)
          @default_layout ||= html_attributes_hash
        end

        #   def inherited(child)
        #     child.instance_variable_set(:@default_layout, @default_layout.clone)

        # if (super_m = method(__method__).super_method)
        #   super_m.call(child)
        # end
        #   end
      end
    end
  end
end

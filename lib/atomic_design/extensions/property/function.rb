# frozen_string_literal: true

module AtomicDesign
  module Extensions
    module Property
      # プロパティ機能の基底クラス
      class Function < ::Hash
        # REQUIRED_OPTIONS = [ :name, :type ]
        ALLOW_OPTIONS = [ :name, :type, :to, :required, :default ]

        def initialize(**kwargs)
          unless skip_option_check
            invalid_keys = kwargs.keys - allowed_options
            raise ArgumentError, "Invalid options: #{invalid_keys.join(', ')}" unless invalid_keys.empty?
            # raise ArgumentError, "Missing required options: #{REQUIRED_OPTIONS.join(', ')}" unless kwargs.include?(*REQUIRED_OPTIONS)
          end

          super
          self.default = nil
          self.update(**kwargs)
        end

        def name
          self[:name]
        end

        def type
          self[:type]
        end

        # TODO: メソッド名として使え無さそうだからコメントアウト
        # def default
        #   self[:default]
        # end

        def required?
          !!self[:required]
        end

        # def required
        #   self[:required]
        # end

        # HTMLを返す場合は、html_options へ展開される
        # => initialize -> handler -> dispacher -> resolver を確認
        # :html
        def to
          self[:to] || :value
        end

        # true の場合、メソッドとして利用できる
        # component = Component.new(color: :red)
        # component.color
        # # => :red
        def use_method
          false
        end

        protected

        def allow_options
          raise NotImplementedError
        end

        def skip_option_check
          false
        end

        private

        def allowed_options
          ALLOW_OPTIONS + allow_options
        end
      end
    end
  end
end

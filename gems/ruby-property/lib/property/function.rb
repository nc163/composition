# frozen_string_literal: true

module Property
  # プロパティ機能の基底クラス
  class Function
    ALLOW_OPTIONS = [ :name, :to, :required, :default ]

    attr_accessor :name, :to, :required, :default

    def initialize(**kwargs)
      unless skip_option_check
        invalid_keys = kwargs.keys - allowed_options
        raise ArgumentError, "Invalid options: #{invalid_keys.join(', ')}" unless invalid_keys.empty?
      end

      kwargs.each do |k, v|
        send("#{k}=", v) if respond_to?("#{k}=")
      end
    end

    def type 
      raise NotImplementedError
    end

    # TODO: メソッド名として使え無さそうだからコメントアウト
    # def default
    #   self[:default]
    # end

    def required?
      !!self.required
    end

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

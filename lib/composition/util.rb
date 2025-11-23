# frozen_string_literal: true

module Composition
  module Util
    def merge_html_options(key, a, b)
      case a
      when Hash
        raise ArgumentError, "Incompatible types #{a.class} and #{b.class}" unless b.is_a?(Hash)
        a.merge(b, &method(:merge_html_options))
      when String, Array
        if b.is_a?(String) || b.is_a?(Array)
          (Array(a) + Array(b)).join(" ")
        else
          raise ArgumentError, "Incompatible types #{a.class} and #{b.class}"
        end
      else
        raise ArgumentError, "Incompatible types #{a.class} and #{b.class}" unless a.class == b.class
        [ a, b ]
      end
    end
  end
end

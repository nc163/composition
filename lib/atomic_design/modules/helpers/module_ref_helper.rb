# frozen_string_literal: true

module AtomicDesign
  module Modules
    module Helpers
      # モジュール内で特定の名前空間の参照を制御する
      # TODO: 本当はrubocopで検出したいけど辛そう
      # TODO: 実行時チェックも辛そう
      module ModuleRefHelper
        extend ActiveSupport::Concern
      end
    end
  end
end

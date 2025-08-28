# frozen_string_literal: true

# コメント
class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :user
end

# frozen_string_literal: true

# 投稿
class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
end

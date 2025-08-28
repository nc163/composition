# frozen_string_literal: true

# ユーザー
class User < ApplicationRecord
  aasm column: :state do
    state :standby, initial: true
    state :active
    state :abuse
    after_all_transitions -> { self.state_changed_at = Time.zone.now }
    event :activate do
      transitions from: [:standby], to: :active
    end
    event :ban do
      transitions from: [:active], to: :abuse
    end
  end

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
end

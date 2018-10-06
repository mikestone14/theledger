class Season < ApplicationRecord
  has_many :games, dependent: :destroy
  has_many :leaderboards, dependent: :destroy

  validate :one_active_season
  validates :name, presence: true
  validates :status, presence: true

  enum status: { active: 0, inactive: 1 }

  def self.active_season
    active.last
  end

  def game_count
    games.count
  end

  private

  def one_active_season
    return unless active? && Season.active.exists?

    errors.add(:status, "can only be active in one season")
  end
end

class Season < ApplicationRecord
  has_many :games

  validate :one_active_season
  validates :name, presence: true
  validates :status, presence: true

  enum status: { active: 0, inactive: 1 }

  def self.active_season
    active.last
  end

  private

  def one_active_season
    if active? && Season.active.exists?
      errors.add(:status, "can only be active in one season")
    end
  end
end
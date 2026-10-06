class Geek < ApplicationRecord
  has_many :applies, dependent: :destroy

  validates :name, presence: true
  validates :stack, presence: true
end
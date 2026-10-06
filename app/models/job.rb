class Job < ApplicationRecord
  belongs_to :company
  has_many :applies, dependent: :destroy

  validates :name, presence: true
  validates :place, presence: true
end
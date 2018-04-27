class Area < ApplicationRecord
  has_one :user
  has_many :runners

  validates :name, presence: true, inclusion: { in: ["Southwark", "Westminster", "Islington", "Camden"] }
end

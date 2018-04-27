class Runner < ApplicationRecord
  belongs_to :area
  has_many :memberships, dependent: :destroy
  # belongs_to :user, through: :areas

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :status, presence: true, inclusion: { in: ["never_run", "regular", "lapsed"] }
  validates :email, presence: true
  validates :area, presence: true
end

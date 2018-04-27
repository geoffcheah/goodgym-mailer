class Preference < ApplicationRecord
  has_many :memberships, dependent: :destroy

  validates :name, presence: true, inclusion: { in: ["GroupRun", "Mission", "CoachRun"] }
end

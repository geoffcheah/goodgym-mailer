class PersonalisedEmail < ApplicationRecord
  belongs_to :user

  validates :subject, presence: true
  validates :content, presence: true
  validates :status, presence: true, inclusion: { in: ["never_run", "regular", "lapsed"]}
end

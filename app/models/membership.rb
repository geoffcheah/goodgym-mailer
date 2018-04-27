class Membership < ApplicationRecord
  belongs_to :preference
  belongs_to :runner

  validates :runner, presence: true
  validates :preference, presence: true
end

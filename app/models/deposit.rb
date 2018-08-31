class Deposit < ApplicationRecord
  belongs_to :user

  # validations
  validates :user_id, :amount, presence: true
  validates :amount, numericality: { only_integer: true }
end

class Deposit < ApplicationRecord
  belongs_to :user

  # validations
  validates :user_id, :amount, presence: true
  validates :amount, numericality: { only_integer: true, greater_than: 0 }

  # update user balance after deposit
  after_create :update_balance

  private
  def update_balance
    balance = self.user.balance + self.amount  
    self.user.update_attribute(:balance, balance)
  end
end

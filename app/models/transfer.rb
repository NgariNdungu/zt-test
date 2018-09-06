class Transfer < ApplicationRecord
  # association to the User model
  belongs_to :sender, class_name: 'User'
  belongs_to :recipient, class_name: 'User'

  # validations
  validates :sender_id, :amount, presence: true
  validates :recipient_id, presence: { message: "Recipient not found" }
  validates :amount, numericality: { only_integer: true, greater_than: 0 }
  validate do |transfer|
    transfer.errors[:amount] << "You have insufficient funds" if transfer.sender.balance < transfer.amount
  end

  # update user balances
  before_create :update_balances

  private

  def update_balances
    sender_balance = self.sender.balance
    recipient_balance = self.recipient.balance
    self.sender.update_attribute(:balance, sender_balance - amount)
    self.recipient.update_attribute(:balance, recipient_balance + amount)
  end
  
end

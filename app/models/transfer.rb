class Transfer < ApplicationRecord
  # association to the User model
  belongs_to :sender, class_name: 'User'
  belongs_to :recipient, class_name: 'User'

  # validations
  validates :sender_id, :recipient_id, :amount, presence: true
  validates :amount, numericality: {only_integer: true}
end

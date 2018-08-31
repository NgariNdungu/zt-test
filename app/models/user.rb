class User < ApplicationRecord
  has_secure_password

  # association to transfers table
  # https://www.sitepoint.com/community/t/referencing-the-same-model-twice-in-rails/254243/2
  has_many :sends, class_name: "Transfer", foreign_key: "sender_id"
  has_many :receipts, class_name: "Transfer", foreign_key: "recipient_id"
  has_many :deposits 

  # validations
  validates :email, :phone, :password_digest, presence: true
  validates :email, :phone, uniqueness: true
  validates :phone, numericality: { only_integer: true }
  
end

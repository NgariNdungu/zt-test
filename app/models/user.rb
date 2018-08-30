class User < ApplicationRecord
  has_secure_password

  # validations
  validates :email, :phone, :password_digest, presence: true
  validates :email, :phone, uniqueness: true
  validates :phone, numericality: { only_integer: true }
  
end

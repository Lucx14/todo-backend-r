class User < ApplicationRecord
  # password encryption
  has_secure_password

  has_many :todos, dependent: :destroy, foreign_key: :created_by, inverse_of: :user

  validates :name, presence: true
  validates :email, presence: true
  validates :password_digest, presence: true
end

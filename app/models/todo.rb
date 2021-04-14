class Todo < ApplicationRecord
  has_many :items, dependent: :destroy

  belongs_to :user, optional: false, foreign_key: :created_by, inverse_of: :todos

  validates :title, presence: true
  validates :created_by, presence: true
end

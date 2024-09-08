class Laboratory < ApplicationRecord
  belongs_to :user
  has_many :exams, dependent: :destroy

  validates :name, :address, :city, :email, presence: true
end

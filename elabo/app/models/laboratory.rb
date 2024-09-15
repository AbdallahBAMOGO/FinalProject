class Laboratory < ApplicationRecord
  belongs_to :user
  has_many :exams, dependent: :destroy

  validates :name, :address, :city, :email, :latitude, :longitude, presence: true
end

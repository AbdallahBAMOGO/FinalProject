class Exam < ApplicationRecord
  has_many :appointments, dependent: :destroy
  belongs_to :laboratory
end

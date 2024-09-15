class Appointment < ApplicationRecord
  belongs_to :user
  belongs_to :exam
  validates :date, presence: true



  enum status: { pending: 'pending', confirmed: 'confirmed', cancelled: 'cancelled' }

  validates :status, inclusion: { in: statuses.keys }
end

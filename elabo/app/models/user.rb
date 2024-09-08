class User < ApplicationRecord

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  # Devise modules: :database_authenticatable, :registerable, etc.
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :contact, presence: true, format: { with: /\A[0-9+\-()\s]*\z/, message: "doit être un numéro de téléphone valide" }
  # Ajoutez d'autres validations et méthodes ici
  # Validation for roles

  validates :user_type, presence: true, inclusion: { in: %w[patient laborantin] }

  def laborantin?
    self.user_type == 'laborantin'
  end

  def patient?
    self.user_type == 'patient'
  end

  has_many :laboratories
end

class User < ApplicationRecord
  # Include all devise modules.
  devise :database_authenticatable, :registerable, :recoverable, 
    :rememberable, :validatable, :confirmable, 
    :trackable, :lockable, :omniauthable, :timeoutable

  # Main Attributes: (excl. devise)
  # Email, Name, Incomes

  has_many :income_sources
end

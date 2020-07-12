class IncomeSource < ApplicationRecord
  # Name, Amount, Frequency

  validates :frequency, presence: true

  belongs_to :user

  monetize :amount_cents

end

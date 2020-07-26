class IncomeSource < ApplicationRecord
  # Name, Amount, Frequency

  validates :frequency, presence: true

  belongs_to :user
  belongs_to :frequency

  monetize :amount_cents

  accepts_nested_attributes_for :frequency

end

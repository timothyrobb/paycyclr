class Payment < ApplicationRecord
  # type, name, account, amount, due_date, optional, skipped_at, schedule

  belongs_to :user
  belongs_to :schedule, class_name: "ScheduledPayment", optional: true

  validates_presence_of :name, :amount, :user
  validates_presence_of :due_date, if: -> (payment) { [nil, "Payment"].include?(payment.type) }

  scope :one_offs, -> { where(type: [nil, "Payment"]) }
  
end

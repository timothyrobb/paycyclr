class Payment < ApplicationRecord
  # type, name, account, amount, due_date, optional, skipped_at, schedule

  default_scope { order(account: :asc, amount_cents: :desc) }

  monetize :amount_cents

  belongs_to :user
  belongs_to :schedule, class_name: "::PaymentSchedule", optional: true

  validates_presence_of :name, :amount, :user
  validates_presence_of :due_date, if: -> (payment) { [nil, "Payment"].include?(payment.type) }

  scope :one_offs, -> { where(type: [nil, "Payment"]) }
  scope :due, -> { where("due_date < ?", Time.current) }
  scope :in_cycle, -> (income_frequency) { where(due_date: income_frequency.next_range) }
  scope :active, -> { where(paid_at: nil, skipped_at: nil) }
  scope :paid, -> { where.not(paid_at: nil) }
  scope :skipped, -> { where.not(skipped_at: nil) }

  def pay!
    update_attributes(paid_at: Time.current)
  end

  def skip!
    update_attributes(skipped_at: Time.current)
  end

  def paid?
    !!paid_at
  end

  def skipped?
    !!skipped_at
  end
  
end

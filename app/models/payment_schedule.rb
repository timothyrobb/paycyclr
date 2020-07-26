class PaymentSchedule < Payment
  # type, name, account, amount, due_date, optional, skipped_at, frequency
  has_many :payments, class_name: "Payment", foreign_key: :schedule_id
  belongs_to :frequency

  validates_presence_of :frequency

  accepts_nested_attributes_for :frequency

  scope :schedules, -> { where(type: ["PaymentSchedule"]) }

  after_create :create_first_payment

  def schedule
    nil # Prevent nesting of schedules
  end

  def next_payment
    payment_params = self.attributes.except("id", "type")
    payment_params[:due_date] = frequency.next_date
    payments.build(payment_params)
  end

  def create_first_payment
    next_payment.save
  end
end

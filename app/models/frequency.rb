class Frequency < ApplicationRecord

  validates_presence_of :name, :slug, :base_days, :amount

  # TODO: Set up amount config properly

  def base_days(date: Date.current)
    if slug.to_sym == :monthly
      Time.days_in_month(date.month, date.year)
    else
      super()
    end
  end

  def days
    base_days * amount
  end

end

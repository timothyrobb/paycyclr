class Frequency < ApplicationRecord

  validates_presence_of :slug, :amount, :start_date

  SLUGS = %w(days weeks fortnights months)

  def self.select_options
    SLUGS.map do |slug|
      [slug.capitalize, slug]
    end
  end

  def name
    slug.capitalize
  end

  def base_days(date: Date.current)
    case slug.to_sym
    when :days
      1
    when :weeks
      7
    when :fortnightly
      14
    when :monthly
      Time.days_in_month(date.month, date.year)
    else
      1
    end
  end

  def next_date
    start_date + (base_days * amount - 1).days
  end

  def end_date
    next_date + (base_days * amount - 1).days
  end

  def next_range
    next_date..end_date
  end

end

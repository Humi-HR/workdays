# frozen_string_literal: true

# This module contains methods to help with dates
module Workdays
  DEFAULT_LOCALE = [:ca].freeze

  module DateExtensions
    def workday?(locale = DEFAULT_LOCALE)
      on_weekday? && !holiday?(locale, :observed)
    end

    def last_workday(locale = DEFAULT_LOCALE)
      day = self - 1.day
      day -= 1.day until day.workday?(locale)
      day
    end

    def to_workday(locale = DEFAULT_LOCALE)
      day = self
      return day if day.workday?(locale)
      day.last_workday(locale)
    end

    def workdays_after(delta = 0, locale = DEFAULT_LOCALE)
      workdays_before(-delta, locale)
    end

    def workdays_before(delta = 0, locale = DEFAULT_LOCALE)
      day   = self
      days  = delta.abs

      while days.positive? || !day.workday?(locale)
        days -= 1 if day.workday?(locale)
        day  -= delta.positive? ? 1.day : -1.days
      end

      day
    end
  end

  class << self
    # Inclusive of start and end dates
    def days_in(start_date, end_date)
      (end_date.to_date - start_date.to_date).to_i + 1
    end

    def workdays_in(start_date, end_date, locale = DEFAULT_LOCALE)
      total_days = days_in(start_date, end_date)
      weekends   = (start_date..end_date).map(&:on_weekend?).count(true)

      holidays   = Holidays.between(start_date, end_date, locale, :observed).map do |x|
        x[:date].on_weekday?
      end.count(true)

      total_days - weekends - holidays
    end
  end
end

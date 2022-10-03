# frozen_string_literal: true

# This module contains methods to help with dates
module Workdays
  DEFAULT_LOCALE = [:ca_on].freeze

  module TimeExtensions
    def workday?(locale = DEFAULT_LOCALE)
      on_weekday? && !to_date.holiday?(locale, :observed)
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
      day  = self
      days = delta.abs

      while days.positive? || !day.workday?(locale)
        days -= 1 if day.workday?(locale)
        day  -= delta.positive? ? 1.day : -1.days
      end

      day
    end
  end

  class << self
    def workdays_in(start_time, end_time, locale = DEFAULT_LOCALE)
      total_days = days_in(start_time, end_time)
      weekends   = weekends_in(start_time, end_time)
      holidays   = non_weekend_holidays_in(start_time, end_time, locale)

      total_days - weekends - holidays
    end

    # Inclusive of start and end dates
    def days_in(start_time, end_time)
      (end_time.to_date - start_time.to_date).to_i + 1
    end

    private

    def weekends_in(start_time, end_time)
      (start_time..end_time).map(&:on_weekend?).count(true)
    end

    def non_weekend_holidays_in(start_time, end_time, locale = DEFAULT_LOCALE)
      start_date  = start_time.to_date
      end_date    = end_time.to_date

      Holidays.between(start_date, end_date, locale, :observed).map do |holiday|
        holiday[:date].on_weekday?
      end.count(true)
    end
  end
end

# frozen_string_literal: true

require "holidays/core_extensions/date"

class Date
  include Holidays::CoreExtensions::Date
  include Workdays::TimeExtensions
end

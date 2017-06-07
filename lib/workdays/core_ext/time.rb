# frozen_string_literal: true

require "holidays/core_extensions/time"

class Time
  include Holidays::CoreExtensions::Time
  include Workdays::DateExtensions
end

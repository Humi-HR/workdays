# Workdays

A hard-working collection of methods to make calculating working dates easier.

This gem provides a number of convenience methods to simplify calculating dates while respecting non-working days. Uses the Holiday gem so that holiday schedules can be localized and customized.

## Installation

Add this line to your application's Gemfile:

```ruby
gem "workdays"
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install workdays

## Usage

By default, Workdays will use `:ca` as the default locale.

```ruby
Date.new(2017, 2, 8)  .workday? # => true
Date.new(2017, 12, 25).workday? # => false

fri_before_family_day = Date.new(2016, 2, 12) # Fri, 12 Feb 2016
family_day            = Date.new(2016, 2, 15) # Mon, 15 Feb 2016
tues_after_family_day = Date.new(2016, 2, 16) # Tue, 16 Feb 2016

family_day.workday?(:ca_on)                       # => false
family_day.workday?(:ca_qc)                       # => true

tues_after_family_day.last_workday(:ca_on)        # => Fri, 12 Feb 2016
tues_after_family_day.last_workday(:ca_qc)        # => Mon, 15 Feb 2016
tues_after_family_day.workdays_before(1, :ca_on)  # => Fri, 12 Feb 2016
tues_after_family_day.workdays_before(1, :ca_qc)  # => Mon, 15 Feb 2016
tues_after_family_day.workdays_after(-1, :ca_qc)  # => Mon, 15 Feb 2016

fri_before_family_day.workdays_after(1, :ca_on)   # => Tue, 16 Feb 2016
fri_before_family_day.workdays_after(1, :ca_qc)   # => Mon, 15 Feb 2016


Workdays.workdays_in(fri_before_family_day, family_day, :ca_on) # => 1
Workdays.workdays_in(fri_before_family_day, family_day, :ca_qc) # => 2
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/julienroger/validatr.


## License

[MIT](./LICENSE)

Copyright (c) 2017 Julien Roger

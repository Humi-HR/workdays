# frozen_string_literal: true

require "spec_helper"

describe Workdays do
  let(:today)           { Date.today                  }
  let(:saturday_date)   { Date.new(2016, 2, 6)        }
  let(:saturday_time)   { saturday_date.to_time(:utc) }
  let(:sunday_date)     { Date.new(2016, 2, 7)        }
  let(:sunday_time)     { sunday_date.to_time(:utc)   }
  let(:monday_date)     { Date.new(2016, 2, 8)        }
  let(:monday_time)     { monday_date.to_time(:utc)   }
  let(:family_day)      { Date.new(2016, 2, 15)       } # Monday
  let(:st_patricks_day) { Date.new(2016, 3, 17)       } # Thursday
  let(:good_friday)     { Date.new(2016, 3, 25)       } # Friday
  let(:civic_holiday)   { Date.new(2016, 8, 1)        } # Monday
  let(:labour_day)      { Date.new(2016, 9, 5)        } # Monday
  let(:christmas)       { Date.new(2017, 12, 25)      } # Monday

  describe "#workday?" do
    context "with locale Canada" do
      example { expect(saturday_date  .workday?).to eq false  }
      example { expect(monday_date    .workday?).to eq true   }
      example { expect(good_friday    .workday?).to eq false  }
      example { expect(labour_day     .workday?).to eq false  }
      example { expect(christmas      .workday?).to eq false  }
      example { expect(family_day     .workday?).to eq true   }
      example { expect(st_patricks_day.workday?).to eq true   }
      example { expect(civic_holiday  .workday?).to eq true   }
    end

    context "with locale Ontario" do
      example { expect(saturday_date  .workday?([:ca_on])).to eq false  }
      example { expect(monday_date    .workday?([:ca_on])).to eq true   }
      example { expect(family_day     .workday?([:ca_on])).to eq false  }
      example { expect(good_friday    .workday?([:ca_on])).to eq false  }
      example { expect(civic_holiday  .workday?([:ca_on])).to eq true   }
      example { expect(labour_day     .workday?([:ca_on])).to eq false  }
      example { expect(christmas      .workday?([:ca_on])).to eq false  }
      example { expect(st_patricks_day.workday?([:ca_on])).to eq true   }
    end

    context "with locale Quebec" do
      example { expect(saturday_date  .workday?([:ca_qc])).to eq false  }
      example { expect(monday_date    .workday?([:ca_qc])).to eq true   }
      example { expect(labour_day     .workday?([:ca_qc])).to eq false  }
      example { expect(christmas      .workday?([:ca_qc])).to eq false  }
      example { expect(good_friday    .workday?([:ca_qc])).to eq false  }
      example { expect(family_day     .workday?([:ca_qc])).to eq true   }
      example { expect(civic_holiday  .workday?([:ca_qc])).to eq true   }
      example { expect(st_patricks_day.workday?([:ca_qc])).to eq true   }
    end
  end

  describe "#last_workday" do
    example { expect(saturday_date        .last_workday).to eq saturday_date - 1.day  }
    example { expect(monday_date          .last_workday).to eq monday_date - 3.days   }
    example { expect((monday_date + 1.day).last_workday).to eq monday_date            }
    example { expect((christmas + 1.day)  .last_workday).to eq christmas - 3.days     }
  end

  describe "#workdays_after" do
    example { expect(monday_date.workdays_after(0)) .to eq monday_date          }
    example { expect(monday_date.workdays_after(-1)).to eq monday_date - 3.days }
    example { expect(monday_date.workdays_after(1)) .to eq monday_date + 1.day  }
    example { expect(monday_date.workdays_after(5)) .to eq monday_date + 7.days }
  end

  describe "#workdays_before" do
    example { expect(monday_date.workdays_before(0)) .to eq monday_date          }
    example { expect(monday_date.workdays_before(-1)).to eq monday_date + 1.day  }
    example { expect(monday_date.workdays_before(1)) .to eq monday_date - 3.days }
    example { expect(monday_date.workdays_before(5)) .to eq monday_date - 7.days }
  end

  describe ".days_in" do
    example { expect(described_class.days_in(today, today))        .to eq 1 }
    example { expect(described_class.days_in(today, today + 1.day)).to eq 2 }
  end

  describe ".workdays_in" do
    let(:w) { described_class }

    example { expect(w.workdays_in(monday_date,   monday_date))             .to eq 1 }
    example { expect(w.workdays_in(saturday_date, monday_date))             .to eq 1 }
    example { expect(w.workdays_in(christmas,     christmas))               .to eq 0 }
    example { expect(w.workdays_in(labour_day - 2.days, labour_day + 1.day)).to eq 1 }
  end
end

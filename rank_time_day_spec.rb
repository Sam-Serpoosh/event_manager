require_relative "./rank_time_day"

describe RankTimeDay do
  context "#busiest_hour_of_registration" do
    it "fetches the hour from the registration datetime" do
      reg_datetime = "11/12/08 10:47"
      subject.fetch_hour_from(reg_datetime).should == 10
    end

    it "increase the count of each hour slot based on reg datetime" do
      reg_datetime = "11/12/08 10:47"
      subject.update_hour_slot_count(reg_datetime)
      subject.reg_count_of(10).should == 1
    end

    it "orders the hour slots descendingly" do
      reg_datetimes = ["11/12/08 10:47", "11/12/08 12:47",
        "11/12/08 10:47", "11/12/08 16:47",
        "11/12/08 10:47", "11/12/08 16:47"]
      reg_datetimes.each do |datetime|
        subject.update_hour_slot_count(datetime)
      end
      subject.busiest_hour.should == 10
    end
  end

  context "#busiest_days_of_registration" do
    it "fetches the week day" do
      weekday = subject.fetch_weekday_from("11/12/08 10:47")
      weekday.should == 3
    end

    it "increase the count of each weekday based on the reg datetiem" do
      reg_datetime = "11/12/08 10:47"
      subject.update_weekdays_count(reg_datetime)
      subject.reg_count_of_weekday(3).should == 1
    end

    it "fetches the two busiest weekdays in registration" do
      reg_dates = ["11/12/08 10:40", "11/13/08 10:40",
                   "11/12/08 10:40", "11/16/08 10:40",
                   "11/12/08 10:40", "11/13/08 10:40"]
      reg_dates.each do |reg_datetime|
        subject.update_weekdays_count(reg_datetime)
      end
      subject.busiest_days.should == ["Wednesday", "Thursday"]
    end
  end
end

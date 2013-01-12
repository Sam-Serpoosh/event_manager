require_relative "./rank_time"

describe RankTime do
  it "fetches the hour from the registration datetime" do
    reg_datetime = "11/12/08 10:47"
    RankTime.new.fetch_hour_from(reg_datetime).should == 10
  end

  it "increase the count of each hour slot based on reg datetime" do
    reg_datetime = "11/12/08 10:47"
    rank_time = RankTime.new
    rank_time.update_hour_slot_count(reg_datetime)
    rank_time.reg_count_of(10).should == 1
  end

  it "orders the hour slots descendingly" do
    reg_datetimes = ["11/12/08 10:47", "11/12/08 12:47",
                     "11/12/08 10:47", "11/12/08 16:47",
                     "11/12/08 10:47", "11/12/08 16:47"]
    rank_time = RankTime.new
    reg_datetimes.each do |datetime|
      rank_time.update_hour_slot_count(datetime)
    end
    rank_time.busiest_hour.should == 10
  end
end

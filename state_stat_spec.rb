require_relative "./state_stat"

describe StateStats do
  it "does nothing for nil state" do
    subject.update_state_stats(nil)
  end
  
  it "adds the state if it already doesn't exist" do
    subject.update_state_stats("MI")
    subject.attendees_from(:MI).should == 1
  end

  it "increases number of attendees from a state" do
    subject.update_state_stats("MI")
    subject.update_state_stats("MI")
    subject.attendees_from(:MI).should == 2
  end

  it "returns 0 for non-existent states" do
    subject.attendees_from(:non_existent).should == 0
  end

  it "returns the list of well-formatted stats and sorted by state name" do
    subject.update_state_stats("MI")
    subject.update_state_stats("MI")
    subject.update_state_stats("MI")
    subject.update_state_stats("CA")
    subject.update_state_stats("CA")
    subject.update_state_stats("IL")
    subject.stats.should == ["CA\t2\t(2)", "IL\t1\t(3)", "MI\t3\t(1)"]
  end
end

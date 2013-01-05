require_relative "sunlight_wrapper"

module Sunlight
  class Legislator; end
end

describe SunlightWrapper do
  it "delegates to sunlight for getting representatives by zipcode" do
    zipcode = "49504"
    leg1, leg2 = stub, stub
    Sunlight::Legislator.should_receive(:all_in_zipcode).with(zipcode).
      and_return([leg1, leg2])
    legislators = SunlightWrapper.get_representatives(zipcode)
    legislators.should == [leg1, leg2]
  end
end

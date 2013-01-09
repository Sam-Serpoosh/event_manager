require_relative "event_manager"

describe EventManager do
  it "cleans the line" do 
    event_manager = EventManager.new("anything")
    line = { homephone: "1(616)666-1500", 
             name: "sam", zipcode: "234" }
    cleaned_line = event_manager.clean_line(line)

    cleaned_line[:homephone].should == "6166661500"
    cleaned_line[:zipcode].should == "00234"
    cleaned_line[:name].should == "sam"
  end
end

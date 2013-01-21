require_relative "event_manager"

describe EventManager do
  it "cleans the attendee informaiton" do 
    event_manager = EventManager.new("anything")
    attendee_info = { homephone: "1(616)666-1500", 
                      name: "sam", zipcode: "234" }
    cleaned_info = event_manager.clean_attendee_info(attendee_info)

    cleaned_info[:homephone].should == "6166661500"
    cleaned_info[:zipcode].should == "00234"
    cleaned_info[:name].should == "sam"
  end
end

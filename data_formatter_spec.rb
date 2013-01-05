require_relative "data_formatter" 

describe DataFormatter do
  context "#clean_number" do
    it "removes junk characters from number" do
      check_cleaned_number("(616)666-1500", "6166661500")
    end

    it "removes the leading 1 if exists" do
      check_cleaned_number("16166661500", "6166661500")
    end

    it "returns invalid number when it's junk number" do
      check_cleaned_number("2616.666-1500(", DataFormatter::INVALID_PHONE_NUMBER)
    end

    it "does nothing for clean number" do 
      check_cleaned_number("6166661500", "6166661500")
    end

    def check_cleaned_number(original_number, expected_cleaned)
      clean_number = DataFormatter.clean_phonenumber(original_number)
      clean_number.should == expected_cleaned
    end
  end

  context "#clean_zipcode" do
    it "returns default zipcode when it's nil" do
      check_cleaned_zipcode(nil, DataFormatter::INVALID_ZIPCODE)
    end

    it "adds leading zeros to make proper length code" do
      check_cleaned_zipcode("234", "00234")
    end
    
    it "does nothing when zipcode is 5 digits long" do
      check_cleaned_zipcode("49504", "49504")
    end

    def check_cleaned_zipcode(original_zipcode, expected_cleaned)
      DataFormatter.clean_zipcode(original_zipcode).should == expected_cleaned
    end
  end

  context "#formatting_representatives_names" do
    it "formats -> title, first initial, lastname, party" do
      legislator = stub(:firstname => "sam", :lastname => "serpoosh", 
                        :title => "senator", :party => "D")
      formatted_name = DataFormatter.format_legislator_name(legislator)
      formatted_name.should == "senator S. serpoosh (D)"
    end
  end
end

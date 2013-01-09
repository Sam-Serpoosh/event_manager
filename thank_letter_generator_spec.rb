require_relative "./thank_letter_generator"

describe ThankLetterGenerator do
  let(:person_info) do
    {
      first_name: "sam",
      last_name: "serpoosh",
      street: "winter",
      city: "Holland",
      state: "MI",
      zipcode: "11090"
    }
  end

  it "creates a letter file for a person" do
    letter_generator = ThankLetterGenerator.new(person_info, "test_files")
    letter_generator.generate_letter
    thank_letter = File.open("test_files/thanks_sam_serpoosh.html", "r").read
    thank_letter.should include("sam")
    thank_letter.should include("serpoosh")
  end
end

class ThankLetterGenerator
  def initialize(person_info, output_dir)
    @person_info = person_info
    @output_dir = output_dir
  end

  def generate_letter
    letter = File.open("form_letter.html", "r").read
    custom_letter = set_info_in_letter(letter)
    create_letter_file(custom_letter)
  end

  def set_info_in_letter(letter)
    custom_letter = letter.gsub("#first_name", @person_info[:first_name].to_s)
    custom_letter = custom_letter.gsub!("#last_name", @person_info[:last_name].to_s)
                                 .gsub!("#street", @person_info[:street].to_s)
                                 .gsub!("#city", @person_info[:city].to_s)
                                 .gsub!("#state", @person_info[:state].to_s)
                                 .gsub!("#zipcode", @person_info[:zipcode].to_s)
    custom_letter
  end

  def create_letter_file(custom_letter)
    file_name = "#{@output_dir}/thanks_#{@person_info[:first_name]}_#{@person_info[:last_name]}.html"
    File.open(file_name, "w") do |f|
      f.print(custom_letter)
    end
  end
end

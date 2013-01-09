require_relative "data_formatter"
require_relative "sunlight_wrapper"
require_relative "thank_letter_generator"
require "csv"

class EventManager
  def initialize(filename) 
    begin
      @file = CSV.open(filename, { headers: true, header_converters: :symbol})
    rescue
      @file = nil
    end
  end

  def output_data(filename)
    @file.rewind
    CSV.open(filename, "w") do |output|
      @file.each do |line|
        output << line.headers if @file.lineno == 2
        output << clean_line(line)
      end
    end
  end

  def create_form_letters
    letter = File.open("form_letter.html", "r") { |f| f.read }
    @file.rewind
    20.times do
      line = @file.readline
      ThankLetterGenerator.new(line, "output").generate_letter
    end
  end

  def representative_lookup
    @file.rewind
    20.times do
      line = @file.readline
      representatives = SunlightWrapper.get_representatives(line[:zipcode])
      formatted_names = format_representatives_names(representatives)
      puts "#{line[:last_name]} => #{formatted_names.join(", ")}"
    end
  end

  def clean_line(line) 
    line[:homephone] = DataFormatter.clean_phonenumber(line[:homephone])
    line[:zipcode] = DataFormatter.clean_zipcode(line[:zipcode])
    line
  end

  private
    def format_representatives_names(representatives)
      representatives.collect do |legislator|
        DataFormatter.format_legislator_name(legislator)
      end 
    end
end

event_manager = EventManager.new("event_attendees.csv")
event_manager.output_data("event_attendees_clean.csv")
event_manager.representative_lookup
event_manager.create_form_letters

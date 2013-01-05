require_relative "data_formatter"
require_relative "sunlight_wrapper"
require "csv"

class EventManager
  def initialize(filename) 
    begin
      @file = CSV.open(filename, { headers: true, header_converters: :symbol})
    rescue
      @file = nil
    end
  end

  def rep_lookup
    20.times do
      line = @file.readline
      representatives = SunlightWrapper.get_representatives(line[:zipcode])
      formatted_names = format_representatives_names(representatives)
      puts "#{line[:last_name]}, #{line[:first_name]}, #{line[:zipcode]}, #{formatted_names.join(", ")}"
    end
  end

  def format_representatives_names(representatives)
    representatives.collect do |legislator|
      DataFormatter.format_legislator_name(legislator)
    end 
  end

  def output_data(filename)
    output = CSV.open(filename, "w")
    @file.each do |line|
      if @file.lineno == 2
        output << line.headers
      end
      output << clean_line(line)
    end
  end

  def clean_line(line) 
    line[:homephone] = DataFormatter.clean_phonenumber(line[:homephone])
    line[:zipcode] = DataFormatter.clean_zipcode(line[:zipcode])
    line
  end
end

EventManager.new("event_attendees.csv").rep_lookup

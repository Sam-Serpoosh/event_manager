require_relative "data_formatter"
require_relative "sunlight_wrapper"
require_relative "thank_letter_generator"
require_relative "rank_time_day"
require_relative "state_stat"
require "csv"

class EventManager
  def initialize(filename) begin
      @file = CSV.open(filename, { headers: true, header_converters: :symbol})
    rescue
      @file = nil
    end
  end

  def output_data(filename)
    @file.rewind
    CSV.open(filename, "w") do |output|
      output_cleaned_attendee_info(output)
    end
  end

  def output_cleaned_attendee_info(output_file)
    @file.each do |attendee_info|
      output_file << attendee_info.headers if @file.lineno == 2
      output_file << clean_attendee_info(attendee_info)
    end
  end

  def create_form_letters
    letter = File.open("form_letter.html", "r") { |f| f.read }
    @file.rewind
    20.times do
      attendee_info = @file.readline
      ThankLetterGenerator.new(attendee_info, "output").generate_letter
    end
  end

  def representative_lookup
    @file.rewind
    20.times do
      attendee_info = @file.readline
      representatives = SunlightWrapper.get_representatives(attendee_info[:zipcode])
      formatted_names = format_representatives_names(representatives)
      puts "#{attendee_info[:last_name]} => #{formatted_names.join(", ")}"
    end
  end

  def clean_attendee_info(attendee_info) 
    attendee_info[:homephone] = DataFormatter.clean_phonenumber(attendee_info[:homephone])
    attendee_info[:zipcode] = DataFormatter.clean_zipcode(attendee_info[:zipcode])
    attendee_info
  end

  def busiest_hour_of_registration
    rank_time = RankTimeDay.new
    @file.rewind
    20.times do
      attendee_info = @file.readline
      rank_time.update_hour_slot_count(attendee_info[:regdate])
    end
    rank_time.busiest_hour
  end

  def busiest_days_of_registration
    rank_time = RankTimeDay.new
    @file.rewind
    20.times do
      attendee_info = @file.readline
      rank_time.update_weekdays_count(attendee_info[:regdate])
    end
    rank_time.busiest_days
  end

  def state_stats
    @file.rewind
    state_stats = StateStats.new
    @file.each do |attendee_info|
      state_stats.update_state_stats(attendee_info[:state])
    end
    state_stats.stats
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
puts event_manager.busiest_hour_of_registration
puts event_manager.busiest_days_of_registration
p event_manager.state_stats

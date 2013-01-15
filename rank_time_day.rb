require 'date'

class RankTimeDay
  def initialize
    @hour_slots = Array.new(24){0}
    @weekdays = Array.new(7) {0}
  end

  def update_hour_slot_count(reg_datetime)
    hour = fetch_hour_from(reg_datetime)
    @hour_slots[hour] += 1
  end

  def update_weekdays_count(reg_datetime)
    weekday = fetch_weekday_from(reg_datetime)
    @weekdays[weekday] += 1
  end
  
  def fetch_hour_from(reg_datetime)
    time = reg_datetime.split(/ /)[1]
    time.split(/:/)[0].to_i
  end
 
  def fetch_weekday_from(reg_datetime)
    date_str = reg_datetime.split(/ /)[0]
    date = Date.strptime(date_str, "%m/%d/%y")
    date.wday
  end

  def reg_count_of(hour)
    @hour_slots[hour]
  end

  def reg_count_of_weekday(weekday)
    @weekdays[weekday]
  end

  def busiest_hour
    @hour_slots.each_with_index.max[1]
  end

  def busiest_days
    busiest_day = @weekdays.each_with_index.max[1]
    @weekdays[busiest_day] = 0 #set to something minimum
    second_busiest_day = @weekdays.each_with_index.max[1]
    [WeekDays.day_of_week(busiest_day), WeekDays.day_of_week(second_busiest_day)]
  end
end

class WeekDays
  @@days = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]

  def self.day_of_week(day_number) 
    @@days[day_number] 
  end
end

class RankTime
  def initialize
    @hour_slots = Array.new(24){0}
  end

  def update_hour_slot_count(reg_datetime)
    hour = fetch_hour_from(reg_datetime)
    @hour_slots[hour] += 1
  end
  
  def fetch_hour_from(reg_datetime)
    time = reg_datetime.split(/ /)[1]
    time.split(/:/)[0].to_i
  end

  def reg_count_of(hour)
    @hour_slots[hour]
  end

  def busiest_hour
    @hour_slots.each_with_index.max[1]
  end
end

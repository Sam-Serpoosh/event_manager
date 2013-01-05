require "sunlight"

class SunlightWrapper
  Sunlight::Base.api_key = "e179a6973728c4dd3fb1204283aaccb5"

  def self.get_representatives(zipcode)
    Sunlight::Legislator.all_in_zipcode(zipcode)
  end
end

class DataFormatter
  VALID_PHONE_NUMBER_LENGTH = 10
  INVALID_PHONE_NUMBER = "0000000000"
  VALID_ZIPCODE_LENGTH = 5
  INVALID_ZIPCODE = "00000"

  def self.clean_phonenumber(number)
    clean_number = number.delete("-").delete(".").delete(" ").
                                   delete("(").delete(")")

    return clean_number if clean_number.length == VALID_PHONE_NUMBER_LENGTH
    if clean_number.length == 11
      return clean_number[1..-1] if clean_number.start_with?("1")
      return INVALID_PHONE_NUMBER
    end
    return INVALID_PHONE_NUMBER
  end

  def self.clean_zipcode(zipcode)
    return INVALID_ZIPCODE if zipcode.nil?
    return zipcode if zipcode.length >= VALID_ZIPCODE_LENGTH
    until zipcode.length == VALID_ZIPCODE_LENGTH
      zipcode.insert(0, "0")
    end
    zipcode
  end

  def self.format_legislator_name(legislator)
    first_initial = legislator.firstname[0].to_s.upcase
    last_name = legislator.lastname
    party = "(#{legislator.party})"
    "#{legislator.title} #{first_initial}. #{last_name} #{party}"
  end
end

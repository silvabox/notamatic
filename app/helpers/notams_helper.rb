require './lib/notam/date_parser'

module NotamsHelper
  DAY_KEYS = Notam::DateParser::DAYS
  DAY_HEADERS = DAY_KEYS.map do |key|
    key.to_s.capitalize
  end

  def day_keys
    DAY_KEYS
  end

  def day_headers
    DAY_HEADERS
  end
end

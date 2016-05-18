require_relative '../notam'

class Notam::DateParser
  REGEX =/(\
(?<day>MON|TUE|WED|THU|FRI|SAT|SUN)\
(-(?<day_to>MON|TUE|WED|THU|FRI|SAT|SUN))?\
(?<times>(\s(\d{4})\-(\d{4}))+|\sCLSD))/

  TIMES_REGEX = /(\d{4}\-\d{4})|(CLSD)/

  DAYS = [:mon, :tue, :wed, :thu, :fri, :sat, :sun]

  def initialize(message)
    fail 'Invalid message format' unless REGEX.match(message)
    parse(message)
  end

  def [](day)
    @days[day]
  end

  private

  def days
    @days ||= {}
  end

  def parse(message)
    message.enum_for(:scan, REGEX).map { Regexp.last_match }.each do |data|
      data[:day_to] ? parse_range(data) : parse_day(data)
    end
  end

  def parse_range(data)
    enumerate_range(data) do |day|
      days[day] = parse_times(data[:times])
    end
  end

  def enumerate_range(data, &block)
    day_from = key_for(data[:day])
    day_to = key_for(data[:day_to])
    range = DAYS.index(day_from)..DAYS.index(day_to)
    DAYS.slice(range).each &block
  end

  def parse_day(data)
    days[key_for(data[:day])] = parse_times(data[:times])
  end

  def key_for(string)
    string.downcase.to_sym
  end

  def parse_times(data)
    data.scan(TIMES_REGEX).flatten.compact
  end
end

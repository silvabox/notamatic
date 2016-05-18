require_relative '../notam'
require_relative 'date_parser'

class Notam::HoursOfService
  attr_reader :notam
  private :notam

  def initialize(notam)
    @notam = notam
  end

  def code
    notam.code
  end

  def message
    notam.message
  end

  def [](day)
    parser[day]
  end

  private

  def parser
    @parser ||= create_parser
  end

  def create_parser
    @parser = Notam::DateParser.new(message)
  end
end

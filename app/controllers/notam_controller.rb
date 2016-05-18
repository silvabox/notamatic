require './lib/notam_parser'
require './lib/notam/hours_of_service'
require './lib/notam/message_filter'

class NotamController < ApplicationController
  def index

  end

  def create
    notam = params[:notam]
    @rows = hours_of_service(notam)
  end

  private

  def hours_of_service(io)
    source = io.open
    parser = NotamParser.new(source)
    filter = Notam::MessageFilter.new(/AERODROME HOURS OF OPS\/SERVICE/)

    parser.each(filter).map do |notam|
      Notam::HoursOfService.new(notam)
    end
  ensure
    io.close
  end
end

class NotamController < ApplicationController
  def index

  end

  def create
    notam = params[:notam]
    render plain: notam.read
  end
end

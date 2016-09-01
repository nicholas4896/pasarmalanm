class LandingController < ApplicationController

  def index
    @tickets = Ticket.all
    if params[:search]
      @tickets = Ticket.search(params[:search])
    else
      @tickets = Ticket.all
    end
  end

end

class LandingController < ApplicationController

  def index

  end

  def search
    items = Item.search params[:search_string]
  end

end

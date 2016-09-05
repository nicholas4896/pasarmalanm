class ItemsController < ApplicationController

  def index
    if params[:search] && params[:search].present?
      @tickets = Item.search(params[:search])
    else
      @tickets = Item.all
    end
  end

  def show
    @ticket = Item.friendly.find(params[:id])
  end
end

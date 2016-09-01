class TicketsController < ApplicationController
  def index
    @item = Item.order(id: :DESC)
    @tickets = Item.all
  end
end

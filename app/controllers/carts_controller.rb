class CartsController < ApplicationController
  before_action :load_cart
  after_action :write_cart, only: [:add_item, :remove_item, :update_item]

  def show
    @items = []
    @cart.each do |k,v|
      item = Item.find_by(id: k)
      item.define_singleton_method(:quantity) do
        v
      end
      @items << item
    end
  end

  def add_item
    if @cart[params[:id]]
      quantity = params[:quantity].to_i
      quantityOld = @cart[params[:id]].to_i
      @cart[params[:id]] = quantityOld + quantity
    else
      @cart[params[:id]] = params[:quantity]
    end
  end

  def update_item
    if @cart[params[:id]]
      @cart[params[:id]] = params[:quantity]
    end
    redirect_to cart_path
  end


  def remove_item
    @cart.delete params[:id]
    redirect_to cart_path
  end

  def load_cart
    if cookies[:cart]
      @cart = JSON.parse(cookies[:cart])
    else
      @cart = {}
    end
  end

  def write_cart
    cookies[:cart] = JSON.generate(@cart)
  end
end

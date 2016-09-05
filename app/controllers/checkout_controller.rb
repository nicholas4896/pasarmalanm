class CheckoutController < ApplicationController

  before_action :load_cart

  def show
    load_items_from_cart
  end

  def payment
    load_items_from_cart
    create_order_from_items

    @token = Braintree::ClientToken.generate

    result = Braintree::Transaction.sale(
      amount: @total_price,
      payment_method_nonce: params[:payment_method_nonce],
      options: {
        submit_for_settlement: true
      }
    )

    if result.success?
      order = Order.create do
        transaction_id = result.transaction.id
        amount = result.transaction.amount
        user_id = current_user&.id
        status = "pending"
      end

      @product.each { |product| order.ordered_items.create(product_id: product.id) }
      cookies.delete(:cart)

      flash[:success] = "We've received payment for your order. You'll receive your order soon"
      redirect_to root_path

    else

      flash[:danger] = "Error placing order, please try again"
      redirect_to checkout_path
    end
  end

  private
  def create_order_from_items
    @order = current_user.orders.build(amount: @total_price)

    @items.each do |item|
      @order.ordered_items.build(quantity: item.quantity, item_id: item.id)
    end
  end

  def load_cart
    if cookies[:cart]
      @cart = JSON.parse(cookies[:cart])
    else
      @cart = {}
    end
  end

  def load_items_from_cart
    @items = []
    @total_price = 0.0

    @cart.each do |k,v|
      item = Item.friendly.find(k)

      item_total = 0
      item_total = item.price * v.to_f
      @total_price += item_total

      item.define_singleton_method(:quantity) { v }
      item.define_singleton_method(:total) { item_total }
      @items << item
    end
  end

end

class OrderController < ApplicationController

  def new
    @token = Braintree::ClientToken.generate
  end

end

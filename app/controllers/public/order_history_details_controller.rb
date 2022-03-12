class Public::OrderHistoryDetailsController < ApplicationController
  def show
    @orders = Order.all
    
  end
end

class Public::CartItemsController < ApplicationController
  def index
    @cart_items = CartItem.all
  end

  def update
    @cart_item.update(quantity: params[:quantity].to_i)
    redirect_to ''
  end

  def destroy
    @cart_item.destroy
    redirect_to ''
  end

  def destroy_all
  end

  def create
    @cart_item = cuurent_customer.cart_item.build(cart_item_params)
    @cart_item.save
  end

  private

  def cart_item_params
    params.require(:cart_item).permit(:item_id, :customer_id, :amount)
  end
end

class Public::CartItemsController < ApplicationController
  def index
    @cart_items = current_customer.cart_items.includes(:item)
  end

  def update
    @cart_item.update(amount: params[:amount].to_i)
    redirect_to ''
  end

  def destroy
    @cart_item = CartItem.find(params[:id])
    if @cart_item.destroy
      redirect_to cart_items_path
    end
  end

  def destroy_all
    @cart_items = current_customer.cart_items.includes(:item)
    @cart_items.destroy_all
      redirect_to cart_items_path
  end

  def create
      @cart_item = current_customer.cart_items.new(cart_item_params)
    if @cart_item.save!
       redirect_to cart_items_path
    end
  end

  private

  def cart_item_params
    params.require(:cart_item).permit(:item_id, :amount)
  end
end

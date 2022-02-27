class Public::ItemsController < ApplicationController
  def index
    @items = Item.all
  end

  def show
      @item = Item.find(params[:id])
      @customer = current_customer
      @cart_item = @customer.cart_item.build(cart_item_params)
    if @cart_item.save
       redirect_to cart_items_path
    end
  end

  private

  def cart_item_params
    params.require(:cart_item).permit(:item_id, :amount)
  end

  def cart_item_params
    params.require(:cart_item).permit(:item_id, :customer_id, :amount)
  end

end

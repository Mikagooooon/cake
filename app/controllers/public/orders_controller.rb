class Public::OrdersController < ApplicationController

  def index
    @orders = Order.all
  end

  def new
    @order = Order.new
    @customer = current_customer
  end

  def confirm
    @order = Oredr.new(order_params)
    @address = Address.find(params[:order][:address_id])
    @order.postal_code = @address.postal_code
    @order.address = @address.address
    @order.name = @address.name
    if @order.save
      flash[:notice] = 'You have created order successfully.'
      redirect_to new_order_path(@order.id)
    else
      render :index
    end
  end

  def complete
  @cart_items = current_customer.cart_items.includes(:item)
  end

  def create
  end

  def show
  end

  private

  def order_params
    params.require(:order).permit(:customer_id,
                                  :postal_code,
                                  :address,
                                  :name,
                                  :postage,
                                  :total_amount,
                                  :payment_method)
  end
end

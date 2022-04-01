class Public::CustomersController < ApplicationController
  before_action :authenticate_customer!

  def show
    @customer = current_customer
  end

  def edit
    @customer = current_customer
    if @customer == current_customer
      render :edit
    else
      redirect_to my_page_path
    end
  end

  def update
    @customer = current_customer
    if @customer.update(customer_params)
      flash[:notice] = "You have updates user successfully."
      redirect_to my_page_path
    else
      render :edit
    end
  end

  def hide
    @customer = current_customer
  end

  def withdrawal
    @customer = current_customer
    @customer.update(is_deleted: true)
    reset_session
    redirect_to root_path, alart: "ありがとうございました。"
  end

  def customer_params
    params.require(:customer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :email, :postal_code, :address, :telephone_number)
  end
end

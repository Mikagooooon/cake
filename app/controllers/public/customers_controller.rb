class Public::CustomersController < ApplicationController
  def show
    @customer = current_customer
  end

  def edit
    @customer = current_customer
    if @customer == current_customer
      render :edit
    else
      redirect_to public_customers_my_page_path
    end
  end

  def update
    @customer = current_customer
    if @customer == current_customer
      flash[:notice] = "You have updates user successfully."
      redirect_to public_customers_my_page_path
    else
      render :edit
    end
  end

  def hide
  end

  def withdrawal
  end
end

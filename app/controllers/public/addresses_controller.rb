class Public::AddressesController < ApplicationController
  before_action :authenticate_customer!
  
  def index
    @addresses = Address.all
    @address = Address.new
  end

  def new
    @address = Addeess.new
  end

  def create
    @address = Address.new(address_params)
    if @address.save
      flash[:notice] = 'You have created address successfully.'
      redirect_to addresses_path
    end
  end

  def edit
    @address = Address.find(params[:id])
  end

  def update
    @address = Address.find(params[:id])
    if @address.update(address_params)
      flash[:hoge] = "You have updated address successfully."
      redirect_to addresses_path
    else
      render :edit
    end
  end

  def destroy
    @address = Address.find(params[:id])
    if @address.destroy
      redirect_to addresses_path
    end
  end

  def address_params
    params.require(:address).permit(:postal_code, :address, :name)
  end
end

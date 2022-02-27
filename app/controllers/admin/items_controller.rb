class Admin::ItemsController < ApplicationController
  before_action :authenticate_admin!, except: [:top]

  def index
    @items = Item.all
    @item = Item.new
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      flash[:notice] = 'You have created item successfully.'
      redirect_to admin_item_path(@item.id)
    else
      render :index
    end
  end

  def show
    @item = Item.find(params[:id])
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
    flash[:hoge] = "You have updated book successfully."
    redirect_to admin_item_path(@item.id)
    else
    render :edit
    end
  end

  private

  def item_params
    params.require(:item).permit(:name, :introduction)
  end
end

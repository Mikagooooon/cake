class Admin::ItemsController < ApplicationController
  def index
    @items = Item.all
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      flash[:notice] = 'You have created item successfully.'
      redirect_to item_path(@item.id)
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
    params.permit(:name, :introduction)
  end
end

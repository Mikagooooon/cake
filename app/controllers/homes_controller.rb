class HomesController < ApplicationController
  def top
    @items = Item.all
    @item = Item.new
  end

  def about
  end
end

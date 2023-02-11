class Public::ItemsController < ApplicationController

  def index
    @items = Item.all
  end

  def show
    @items = Item.find(params[:id])
    @cart_item = CartItem.new
  end

  def create
    item = Item.new(params[:id])
    item.save
    redirect_to public_items_path
  end

  private

  def item_params
    params.require(:item).permit(:name, :introduction, :price, :genre_id, :is_active, :image)
  end

end

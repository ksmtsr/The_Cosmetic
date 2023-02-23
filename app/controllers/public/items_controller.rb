class Public::ItemsController < ApplicationController
  before_action :authenticate_customer!, except: [:index]

  def index
    @items = Item.all.page(params[:page]).per(6)
  end

  def show
    @item = Item.find(params[:id])
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

class Public::HomesController < ApplicationController
  def top
    @items = Item.all
    @items = Item.all.order(created_at: :desc).page(params[:page]).per(3)
  end
end

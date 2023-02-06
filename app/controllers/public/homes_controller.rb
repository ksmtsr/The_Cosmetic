class Public::HomesController < ApplicationController
  def top
    @items = Item.all.page(params[:page]).per(3)
  end
end

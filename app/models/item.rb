class Item < ApplicationRecord

  has_one_attached :image

  has_many :cart_items, dependent: :destroy
  has_many :order_details, dependent: :destroy
  has_many :comments, dependent: :destroy

  def with_tax_price
    (price * 1.1).floor
  end


end

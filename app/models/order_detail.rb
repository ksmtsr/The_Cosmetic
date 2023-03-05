class OrderDetail < ApplicationRecord
  has_one_attached :image

  belongs_to :order
  belongs_to :item

  def with_tax_price
    (price * 1.1).floor
  end

  def subtotal
    item.with_tax_price * amount
  end
end

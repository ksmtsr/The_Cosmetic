class Order < ApplicationRecord

  enum payment_method: { credit_card: 0, transfer: 1 }

  enum status: { waiting_for_payment: 0, payment_confirmation: 1, in_production: 2, preparing_to_ship: 3, sent: 4 }

  belongs_to :customer
  has_many :order_details, dependent: :destroy
  has_many :addresses, dependent: :destroy

  def address_display
  "〒" + postal_code + " " + address + " " + name
  end

  def full_name
    self.last_name + self.first_name
  end

  def full_name_kana
    self.last_name_kana + self.first_name_kana
  end

  def subtotal
    item.with_tax_price * amount
  end

end

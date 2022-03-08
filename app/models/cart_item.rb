class CartItem < ApplicationRecord
  belongs_to :item, optional: true

  def subtotal
      item.with_tax_price * amount
  end

end

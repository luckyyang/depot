class LineItem < ActiveRecord::Base
  attr_accessible :cart_id, :product_id, :product, :quantity
  belongs_to :order
  belongs_to :cart
  belongs_to :product

  def total_price
    product.price * quantity
  end
end

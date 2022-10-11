class CartItem < ApplicationRecord
  belongs_to :department
  belongs_to :item
end

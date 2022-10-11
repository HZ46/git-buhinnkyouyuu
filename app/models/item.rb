class Item < ApplicationRecord
 has_one_attached :image
 #has_one_attached :カラム名
  has_many :cart_items
  has_many :order_details
  
 def self.search(keyword)
  where(["name like?", "%#{keyword}%"])
 end
end

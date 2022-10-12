class Item < ApplicationRecord
 has_one_attached :image
 #has_one_attached :カラム名
  has_many :cart_items
  has_many :order_details
  has_many :bookmarks
 def self.search(keyword)
  where(["name like?", "%#{keyword}%"])
 end
 def bookmarked_by?(department)
    bookmarks.where(department_id: department).exists?
   
    #bookmarks.exists?(department_id: department)
 end
end

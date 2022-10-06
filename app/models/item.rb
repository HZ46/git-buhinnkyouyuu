class Item < ApplicationRecord
 has_one_attached :image
 #has_one_attached :カラム名
 def self.search(keyword)
  where(["name like?", "%#{keyword}%"])
 end
end

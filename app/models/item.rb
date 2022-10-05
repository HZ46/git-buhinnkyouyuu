class Item < ApplicationRecord
 def self.search(keyword)
  where(["name like?", "%#{keyword}%"])
 end
end

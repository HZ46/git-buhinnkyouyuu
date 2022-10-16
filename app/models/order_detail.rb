class OrderDetail < ApplicationRecord
  belongs_to :order
  belongs_to :item
  
  enum making_status: { cannot_start: 0, pikking: 1, completed: 2 }
end

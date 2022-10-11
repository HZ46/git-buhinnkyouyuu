class OrderDetail < ApplicationRecord
  belongs_to :order
  belongs_to :item
  
  enum making_status: { cannot_start: 0, waiting_start: 1, pikking: 2, completed: 3 }
end

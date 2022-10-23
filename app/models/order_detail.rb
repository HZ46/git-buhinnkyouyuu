class OrderDetail < ApplicationRecord
  belongs_to :order
  belongs_to :item

  enum making_status: { cannot_start: 0, pikking: 1, completed: 2 ,deal_closed: 3, sold_out: 99}
end

class Order < ApplicationRecord
  belongs_to :department
  has_many :order_details

  validates :delivery_department, inclusion: { in: ['1階南棟', '1階北棟', '2階南棟', '2階北棟'] }
  enum status: {accepting: 0, preparing_for_delivery: 1, delivered: 2}
end

class Order < ApplicationRecord
  belongs_to :department
  has_many :order_details
  has_many :items

  validates :delivery_department, inclusion: { in: ['1階南棟', '1階北棟', '2階南棟', '2階北棟'] }
end

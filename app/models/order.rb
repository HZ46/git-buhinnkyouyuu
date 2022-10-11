class Order < ApplicationRecord
  belongs_to :department
  has_many :order_details
  has_many :items
end

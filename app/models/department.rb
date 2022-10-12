class Department < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, authentication_keys: [:department_number]
  
  has_many :cart_items
  has_many :orders
  has_many :bookmarks
  
  def has_in_cart(item)
    cart_items.find_by(item_id: item.id)
  end
end

class Department::CartItemsController < ApplicationController
 before_action :authenticate_department!
 before_action :set_cart_item, only: [:update, :destroy]

  def index
    @cart_items = current_department.cart_items
  end

  def create
    @item = Item.find(params[:cart_item][:item_id])
    @cart_items = current_department.cart_items
    if current_department.cart_items.where(item_id: @item.id).present?
      print('=================')
      @cart_item = current_department.cart_items.find_by(item_id: @item.id)
      new_amount = @cart_item.amount + cart_item_params[:amount].to_i
      if @item.amount < new_amount
        print(1111111111)
        redirect_back  fallback_location: root_path, alert: "在庫が足りません"
      else
        @cart_item.update(amount: new_amount)
        print(@cart_item)
        redirect_to cart_items_path
      end
    else
      print('-----------------')
      print(@item.amount)
      print(cart_item_params[:amount].to_i)
      if @item.amount >= cart_item_params[:amount].to_i
        print(22222222222)
        # カートにアイテムを追加する
        @cart_item = current_department.cart_items.new(cart_item_params)
        @cart_item.item_id = @item.id
        if @cart_item.save
          redirect_to cart_items_path
        else
          render 'departments/items/show'
        end
      else
        redirect_back fallback_location: root_path, alert: "在庫が足りません"
      end
    end
  end

  def update
    @cart_item.update(cart_item_params) if @cart_item
    redirect_to cart_items_path
  end

  def destroy
    @cart_item.destroy if @cart_item
    redirect_to cart_items_path
  end

  private

  def cart_item_params
    params.require(:cart_item).permit(:amount)
  end

  def set_cart_item
   @cart_item = CartItem.find(params[:id])
  end
end

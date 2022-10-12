class Department::CartItemsController < ApplicationController
 before_action :authenticate_department!
  #before_action :set_cart_item, only: [:create, :update, :destroy]

  def index
    @cart_items = current_department.cart_items
  end

  def create
    @item = Item.find(params[:cart_item][:item_id])
    @cart_items = current_department.cart_items
    if current_department.cart_items.where(item_id: @item.id).present?
      @cart_item = current_department.cart_items.find_by(item_id: @item.id)
      new_amount = @cart_item.amount + cart_item_params[:amount].to_i
      @cart_item.update(amount: new_amount)
      redirect_to cart_items_path
    else
      @cart_item = current_department.cart_items.new(cart_item_params)
      @cart_item.item_id = @item.id
      if @cart_item.save
        redirect_to cart_items_path
      else
        render 'departments/items/show'
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

  #def destroy_all
   # current_customer.cart_items.destroy_all
    #redirect_to cart_items_path
  #end

  private

  def cart_item_params
    params.require(:cart_item).permit(:amount)
  end

  #def set_cart_item
  #  @item = Item.find(params[:item_id])
  # @cart_item = current_department.has_in_cart(@item)
  #end
end

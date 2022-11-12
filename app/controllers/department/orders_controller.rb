class Department::OrdersController < ApplicationController
   before_action :authenticate_department!

  def new
    @order = Order.new
  end

  def confirmation
    @cart_items = current_department.cart_items
    @order = Order.new
  end

  def error
  end

  def create
    @not_order_item = []
    @order = current_department.orders.new(order_params)
    if @order.save
      # @order.create_order_details(current_department)
      current_department.cart_items.each do |item|
        target_item = Item.find(item.item_id)
        if item.amount <= target_item.amount
        OrderDetail.create!([
            order_id: @order.id,
            item_id: item.item_id,
            amount: item.amount
          ])

         if target_item
          target_item.amount = target_item.amount - item.amount
          if target_item.amount == 0
             target_item.is_active = false
          end
          target_item.save!
         end
        else
         OrderDetail.create!([
            order_id: @order.id,
            item_id: item.item_id,
            amount: item.amount,
            making_status: 99
          ])
          @order.cannot_start!
          @not_order_item.push(target_item)
        end

      end

      current_department.cart_items.destroy_all
    
      render :thanks
    else
      @cart_items = current_department.cart_items
      render :confirmation
    end
    
  end

  def thanks
  end

  def index
    @orders = current_department.orders
  end

  def show
    @order = current_department.orders.find(params[:id])
  end

  private

  def order_params
    params.require(:order).permit(:delivery_department)
  end

end

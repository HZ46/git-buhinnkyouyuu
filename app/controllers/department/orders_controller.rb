class Department::OrdersController < ApplicationController
   before_action :authenticate_department!
  #before_action :ensure_cart_items, only: [:new, :confirm, :create, :error]

  def new
    @order = Order.new
  end

  def confirmation
    # @order = Order.new(orders_params)
    @cart_items = current_department.cart_items
    @order = Order.new
    #if params[:select_address] == '0'
     # @order.get_shipping_informations_from(current_customer)
    #elsif params[:select_address] == '1'
     # @selected_address = current_customer.addresses.find(params[:address_id])
      #@order.get_shipping_informations_from(@selected_address)
    #elsif params[:select_address] == '2' && (@order.postal_code =~ /\A\d{7}\z/) && @order.destination? && @order.name?
      # 処理なし
    #else
      #flash[:error] = '情報を正しく入力して下さい。'
      #render :new
    #end
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

          @not_order_item.push(target_item)
        end

       #if target_item = Item.find(item.item_id)
        # target_item.amount = target_item.amount < item.amount

       #end

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

  # def orders_params
  #   params.require(:order).permit(:delivery_department)
  # end

  #def ensure_cart_items
   # @cart_items = current_department.cart_items.includes(:item)
   # redirect_to items_path unless @cart_items.first
  #end
end

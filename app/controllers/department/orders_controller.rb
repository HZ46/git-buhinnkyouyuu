class Department::OrdersController < ApplicationController
   before_action :authenticate_department!
  #before_action :ensure_cart_items, only: [:new, :confirm, :create, :error]

  def new
    @order = Order.new
  end

  def confirm
    #@order = Order.find(params[:id])
    @cart_items = current_department.cart_items
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
    @order = current_department.orders.new(order_params)
    if @order.save
      @order.create_order_details(current_department)
      redirect_to thanks_path
    else
      render :new
    end
  end

  def thanks
  end

  def index
    @orders = current_department.orders.includes(:order_details, :items).page(params[:page]).reverse_order
  end

  def show
    @order = current_department.orders.find(params[:id])
  end

  private

  def order_params
    params.require(:order).permit(:delivery_department)
  end

  #def ensure_cart_items
   # @cart_items = current_department.cart_items.includes(:item)
   # redirect_to items_path unless @cart_items.first
  #end
end

class Admin::OrdersController < ApplicationController
  before_action :authenticate_admin!
  before_action :ensure_order, only: [:show, :update]

  def index
    if params[:department_id]
      @customer = Customer.find(params[:department_id])
      @orders = @customer.orders.page(params[:page]).reverse_order
    elsif params[:created_at] == "today"
      @orders = Order.ordered_today.includes(:department).page(params[:page]).reverse_order
    else
      @orders = Order.includes(:department).page(params[:page]).reverse_order
    end
  end

  def show
    @order_details = @order.order_details.includes(:item)
    @department = @order.department
  end

  def update
    if @order.update(order_params) && @order.confirm_deposit?
      @order.order_details.update_all(making_status: 0)
    end
    redirect_to admin_order_path(@order)
  end


  private

    def order_params
      params.require(:order_detail).permit(:status)
    end
  
    def ensure_order
      @order = Order.find(params[:id])
    end
end

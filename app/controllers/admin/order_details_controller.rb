class Admin::OrderDetailsController < ApplicationController
   def update
    @order_detail = OrderDetail.find(params[:id])
    @order = @order_detail.order
    #byebug
    @order_details = @order.order_details
    @order_detail.update(order_detail_params)

    if @order_details.where(making_status: "pikking").count 
      @order.status = :accepting
      @order.save
    end

     if @order.order_details.count == @order_details.where(making_status: "completed").count
       @order.status = :preparing_for_delivery
       @order.save
     end
    redirect_to admin_order_path(@order_detail.order.id)
   end

  private

  def order_detail_params
    params.require(:order_detail).permit(:making_status)
  end
end


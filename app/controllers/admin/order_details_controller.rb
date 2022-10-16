class Admin::OrderDetailsController < ApplicationController
   def update
    @order_detail = OrderDetail.find(params[:id])
    @order = @order_detail.order
    #byebug
    @order_details = @order.order_details
    @order_detail.update(order_detail_params)

    if @order_details.where(making_status: "ピッキング中").count >= 1
      @order.status = "承り中"
      @order.save
    end

     if @order.order_details.count == @order_details.where(making_status: "製作完了").count >= 2
       @order.status = "お届け準備中"
       @order.save
     end
    redirect_to admin_order_path(@order_detail.order.id)
   end

  private

  def order_detail_params
    params.require(:order_detail).permit(:making_status)
  end
end

 
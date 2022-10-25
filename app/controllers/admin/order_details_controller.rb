class Admin::OrderDetailsController < ApplicationController
   def update
    @order_detail = OrderDetail.find(params[:id])
    @order = @order_detail.order
    #byebug
    @order_details = @order.order_details
    @order_detail.update(order_detail_params)

    if @order_details.count == @order_details.where(making_status: "sold_out").count
      @order.status = :cannot_start
      @order.save
    end

    if @order_details.count == @order_details.where(making_status: "pikking").count
      @order.status = :accepting
      @order.save
    end

     if @order.order_details.count == @order_details.where(making_status: "completed").count
       @order.status = :preparing_for_delivery
       @order.save
     end

     if @order.order_details.count == @order_details.where(making_status: "deal_closed").count
       @order.status = :delivered
       @order.save
     end


    redirect_to admin_order_path(@order_detail.order.id)
   end

  private

  def order_detail_params
    params.require(:order_detail).permit(:making_status)
  end
end
    #if @order_detail.status == "入金確認"  (一斉にステータス変えるコード)
     # @order_details.each do |order_detail|
      #  order_detail.making_status = "製作待ち"
       # order_detail.save
      #end



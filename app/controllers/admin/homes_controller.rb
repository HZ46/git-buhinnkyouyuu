class Admin::HomesController < ApplicationController
   before_action :authenticate_admin!
    def top
      @orders = Order.all.paginate(page: params[:page], per_page: 10)
    end
end


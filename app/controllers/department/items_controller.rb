class Department::ItemsController < ApplicationController
  def index
    @items = Item.all.paginate(page: params[:page], per_page: 7)
  end


   def search
    @items = Item.search(params[:keyword]).paginate(page: params[:page], per_page: 7)
    @keyword = params[:keyword]
    render "index"
   end

  def show
    @item = Item.find(params[:id])
    @cart_item = CartItem.new
  end

end

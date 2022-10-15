class Department::ItemsController < ApplicationController
   def index
     @items = Item.all.paginate(page: params[:page])
   end

   def search
    @items = Item.search(params[:keyword])
    @keyword = params[:keyword]
    render "index"
   end

  def show
    @item = Item.find(params[:id])
    @cart_item = CartItem.new
  end

end

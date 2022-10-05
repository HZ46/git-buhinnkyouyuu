class User::ItemsController < ApplicationController
   def index

     @items = Item.all
   end

   def search
    @items = Item.search(params[:keyword])
    @keyword = params[:keyword]
    render "index"
   end

  def show
    @item = Item.where_genre_active.find(params[:id])
    @cart_item = CartItem.new
  end
end

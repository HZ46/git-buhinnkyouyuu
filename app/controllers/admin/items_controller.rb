class Admin::ItemsController < ApplicationController
  before_action :authenticate_admin!
  before_action :ensure_item, only: [:show, :edit, :update]

  def new
    @item = Item.new
  end

  def index
    @items = Item.all.paginate(page: params[:page], per_page: 6)
  end

  def create
    @item = Item.new(item_params)
    if @item.save
    redirect_to admin_item_path(@item.id)
    else
    render :index
    end
  end

  def show
  end

  def edit
    @item =  Item.find(params[:id])
  end

  def update
    @item.update(item_params) ? (redirect_to admin_item_path(@item)) : (render :edit)
  end

  def search
    @items = Item.search(params[:keyword])
    @keyword = params[:keyword]
    render "index"
  end


  private

    def item_params
      params.require(:item).permit(:image, :name, :introduction, :amount,  :is_active)
    end
  
    def ensure_item
      @item = Item.find(params[:id])
    end
end

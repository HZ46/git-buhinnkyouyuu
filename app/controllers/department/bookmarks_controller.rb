class Department::BookmarksController < ApplicationController
   def create
    @item = Item.find(params[:item_id])
    bookmark = @item.bookmarks.new(department_id: current_department.id)
    if bookmark.save
      redirect_to request.referer
    else
      redirect_to request.referer
    end
   end

  def destroy
    @item = Item.find(params[:item_id])
    bookmark = @item.bookmarks.find_by(department_id: current_department.id)
    if bookmark.present?
        bookmark.destroy
        redirect_to request.referer
    else
        redirect_to request.referer
    end
  end
end

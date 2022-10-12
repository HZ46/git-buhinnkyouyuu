class Department::DepartmentsController < ApplicationController
   before_action :authenticate_department!
  before_action :set_current_department

  def show
    @bookmarks = Bookmark.where(department_id: current_department.id)
  end

  def edit
  end

  def update
    if @department.update(customer_params)
      redirect_to mypage_path, notice: '会員情報の更新が完了しました。'
    else
      render :edit
    end
  end

  def unsubscribe
  end

  def withdraw
    @department.update(is_active: false)
    reset_session
    redirect_to root_path
  end

  private

  def set_current_department
    @department = current_department
  end

  #def customer_params
    #params.require(:customer).permit(:last_name, :first_name, :first_name_kana, :last_name_kana, :email, :postal_code, :address, :telephone_number)
  #end
end

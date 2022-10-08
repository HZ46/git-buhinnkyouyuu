class Admin::DepartmentsController < ApplicationController
   before_action :authenticate_admin!
  def top
  end
  
  def new
    @department = department.new
  end
  
  def create
    @department = Department.new(department_params)
    @department.save 
    redirect_to admin_department_index_path
    #else
     #@books=Book.all
     #@user=current_user

    #render :index
    #end
  end
  
  def index
    @departments = Department.all
  end
  
  def show
    @department = Department.find(params[:id])
  end
  
  def edit
    @department =  Department.find(params[:id])
  end
  
  def update
    @department.update(depart_params) ? (redirect_to admin_department_path(@department)) : (render :edit)
  end
  
  def destroy
    department = Department.find(params[:id])  # データ（レコード）を1件取得
    department.destroy# データ（レコード）を削除
    redirect_to admin_department_index_path  # 投稿一覧画面へリダイレクト
  end

  private

  def department_params
    params.require(:department).permit(:name)
  end
  
  def depart_params
    params.require(:department).permit(:name)
  end
end

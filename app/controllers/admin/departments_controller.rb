class Admin::DepartmentsController < ApplicationController
  before_action :authenticate_admin!
  def top
  end

  def new
   @department = Department.new
  end

  def create
    @department = Department.new(department_params)
    if @department.save
    redirect_to admin_department_path(@department.id)
    else
     #@books=Book.all
     #@user=current_user

    render :index
    end
  end

  def index
    #@departments = Department.all.order(:department_number)
    @departments = Department.all.order(:department_number).paginate(page: params[:page], per_page: 6)
  end

  def show

    @department = Department.find(params[:id])
  end

  def edit
    @department =  Department.find(params[:id])
  end

  def update
    @department =  Department.find(params[:id])
    if
     @department.update(depart_params)
     redirect_to admin_department_path(@department)
    else
     render :edit
    end
  end

  def destroy
    department = Department.find(params[:id])  # データ（レコード）を1件取得
    department.destroy# データ（レコード）を削除
    redirect_to admin_department_index_path  # 投稿一覧画面へリダイレクト
  end

  def search
    @departments = Department.search(params[:keyword]).paginate(page: params[:page], per_page: 6)
    @keyword = params[:keyword]
    render "index"
  end

  private

    def department_params
      params.require(:department).permit(:name, :department_number, :password)
    end
  
    def depart_params
      params.require(:department).permit(:name, :department_number)
    end
end

class Department::DepartmentsController < ApplicationController
  before_action :authenticate_department!
  before_action :set_current_department

  def show
    @bookmarks = Bookmark.where(department_id: current_department.id)
  end

  def edit
  end

  private

  def set_current_department
    @department = current_department
  end

end

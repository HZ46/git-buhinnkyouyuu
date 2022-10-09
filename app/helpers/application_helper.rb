module ApplicationHelper
  def alignment(department_number)
    format("%06<number>d", number: department_number)
  end
end

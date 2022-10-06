class Admin::HomesController < ApplicationController
   before_action :authenticate_admin!
  def top
    @orders = Order.all
  end
  
  def search
    @model = params['search']['model']
    @content = params['search']['content']
    @method = params['search']['method']
    @result = search_for(@model, @content, @method)
  end

  private

  def search_for(model, content, method)
    if model == 'department'
      if method == 'forward'
        Department.where(
          'name LIKE ?',
          "#{content}%"
        )
      elsif method == 'backward'
        Department.where(
          'name LIKE ?',
          "%#{content}"
        )
      elsif method == 'perfect'
       Department.where(
          'name = ?',
          content
        )
      else # partial
        Department.where(
          'name LIKE ?',
          "%#{content}%"
        )
      end
    elsif model == 'item'
      if method == 'forward'
        Item.where('name LIKE ?', content + '%').includes(:genre)
      elsif method == 'backward'
        Item.where('name LIKE ?', '%' + content).includes(:genre)
      elsif method == 'perfect'
        Item.where(name: content).includes(:genre)
      else # partial
        Item.where('name LIKE ?', '%' + content + '%').includes(:genre)
      end
    else
      [] # 空配列を返す
    end
  end
end


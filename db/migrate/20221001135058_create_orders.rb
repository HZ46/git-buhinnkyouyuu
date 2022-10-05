class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
       t.integer :department_id, null: false
       t.string :delivery_department, null: false
      t.integer :status, null: false, default: 0
      t.timestamps
    end
  end
end

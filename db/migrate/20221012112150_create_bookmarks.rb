class CreateBookmarks < ActiveRecord::Migration[6.1]
  def change
    create_table :bookmarks do |t|
      t.integer :department_id, null: false
      t.integer :item_id, null: false

      t.timestamps
    end
  end
end

class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.integer :category_id, null: false
      t.integer :user_id, null: false
      t.text :text, null: false

      t.timestamps
    end
  end
end

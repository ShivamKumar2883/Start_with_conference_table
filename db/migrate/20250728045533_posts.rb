class CreatePosts < ActiveRecord::Migration[8.0]
  def change
    create_table :posts do |t|
      t.string :title, null:false
      t.string :content, null: false
      t.string :user_id, null:false
      t.string :posted_by, null:false

      t.timestamps
  end
  add_foreign_key :posts, :j_users, column: :user_id
    add_index :posts, :user_id
end
end
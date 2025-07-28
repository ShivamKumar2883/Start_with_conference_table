class CreatePosts < ActiveRecord::Migration[8.0]
  def change
    create_table :posts do |t|
      t.string :titile, null:false, foreign_key: true
      t.string :content, null: false
      t.string :profile_id, null:false
      t.string :posted_by, null:false

      t.timestamps
  end
end
end
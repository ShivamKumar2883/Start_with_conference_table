class CreatePosts < ActiveRecord::Migration[8.0]
  def change
    create_table :posts do |t|
      t.string :title
      t.string :content
      t.bigint :profile_id
      t.string :posted_by

      t.timestamps
    end

    add_foreign_key :posts, :profiles
    add_index :posts, :profile_id
  end
end
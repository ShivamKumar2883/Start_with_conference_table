class CreateProfilePictures < ActiveRecord::Migration[8.0]
  def change
    create_table :profile_pictures do |t|
      t.references :profile, null: false, foreign_key: true
      t.string :image_url
      t.string :user_name

      t.timestamps
    end
  end
end

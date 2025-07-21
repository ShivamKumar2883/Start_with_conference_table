class CreateProfiles < ActiveRecord::Migration[8.0]
  def change
    create_table :profiles do |t|
      t.string :name
      t.string :designation
      t.string :address
      t.string :phone_number
      t.string :profile_pic
      t.string :pincode
      t.references :j_user, null: false, foreign_key: true

      t.timestamps
    end
  end
end

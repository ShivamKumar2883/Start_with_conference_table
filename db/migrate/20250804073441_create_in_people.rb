class CreateInPeople < ActiveRecord::Migration[8.0]
  def change
    create_table :in_people do |t|
      t.string :address, null: false
      t.string :city, null: false
      t.string :pincode, null: false
      t.references :conference, null: false, foreign_key: true
      t.references :state, null: false, foreign_key: true
      t.references :district, null: false, foreign_key: true
    end
  end
end
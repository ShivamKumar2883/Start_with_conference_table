class CreatePocs < ActiveRecord::Migration[8.0]
  def change
    create_table :pocs do |t|
      t.string :name, null: false
      t.string :email, null: false
      t.string :phone, null: false
      t.references :enquires, null: false, foreign_key: true

      t.timestamps
    end
  end
end

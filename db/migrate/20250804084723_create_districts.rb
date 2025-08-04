class CreateDistricts < ActiveRecord::Migration[8.0]
  def change
    create_table :districts do |t|
            t.string :name, null: false
      t.timestamps
    end
  end
end

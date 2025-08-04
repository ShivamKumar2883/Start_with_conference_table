class CreateConferences < ActiveRecord::Migration[8.0]
  def change
    create_table :conferences do |t|
      t.string :title, null: false
      t.text :description, null: false
      t.string :theme
      t.datetime :start_date, null: false
      t.datetime :end_date, null: false
      t.string :image
      t.string :status, null: false, default: "upcoming"
      t.string :event_url
      t.references :j_user, null: false, foreign_key: true
            t.references :pocs, null: false, foreign_key: true


      t.timestamps
    end

    add_index :conferences, :title
    add_index :conferences, :status
    add_index :conferences, :start_date
    add_index :conferences, :end_date
  end
end
class CreateJUsers < ActiveRecord::Migration[8.0]
  def change
    create_table :j_users do |t|
      t.string :email
      t.string :password

    end
  end
end

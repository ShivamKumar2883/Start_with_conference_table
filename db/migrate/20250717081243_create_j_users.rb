class CreateJUsers < ActiveRecord::Migration[8.0]
  def change
    create_table :j_users do |t|
      t.string :email
      t.string :password
      t.string :createdAt
      t.string :updateAt

    end
  end
end

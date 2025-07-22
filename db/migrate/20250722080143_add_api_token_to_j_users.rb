class AddApiTokenToJUsers < ActiveRecord::Migration[8.0]
  def change
    add_column :j_users, :api_token, :string
    add_index :j_users, :api_token, unique: true
  end
end

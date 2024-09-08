class AddDetailsToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :user_type, :string
    add_column :users, :contact, :string
  end
end

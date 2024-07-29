class AddRefreshTokenToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :rt, :string
    add_index :users, :rt
  end
end

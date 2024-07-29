class AddExpirationTokenToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :exp, :datetime
    add_index :users, :exp
  end
end
